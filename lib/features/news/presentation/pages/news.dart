import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/components.dart';
import 'package:probitas_app/core/utils/navigation_service.dart';
import 'package:probitas_app/core/utils/states.dart';
import 'package:probitas_app/features/dashboard/presentation/widget/empty_state/empty_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_appbar.dart';
import '../../../../core/utils/customs/custom_drawers.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../controller/news_controller.dart';
import '../provider/news_provider.dart';
import 'news_overview.dart';

class News extends ConsumerStatefulWidget {
  News({Key? key}) : super(key: key);

  @override
  ConsumerState<News> createState() => _NewsState();
}

class _NewsState extends ConsumerState<News> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  final scrollController = ScrollController();
  final refreshController = RefreshController();

  var source = "Unilorin SU";

  @override
  Widget build(
    BuildContext context,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        key: _key,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: CustomAppbar(
            onPressed: () {
              _key.currentState!.openDrawer();
            },
          ),
        ),
        drawer: ProbitasDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Consumer(
            builder: (context, ref, child) {
              final newsNotifier = ref.watch(newsNotifierProvider);
              return Column(
                children: [
                  YMargin(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "News",
                        style: Config.h3(context).copyWith(
                          color: isDarkMode
                              ? ProbitasColor.ProbitasTextPrimary
                              : ProbitasColor.ProbitasPrimary,
                          fontSize: 18,
                        ),
                      ),
                      PopupMenuButton(
                        // child: Text(""),

                        onSelected: (value) {
                          setState(() {
                            source = value.toString();
                          });
                          ref
                              .read(newsNotifierProvider.notifier)
                              .getNewsForSource(value
                                  .toString()
                                  .toLowerCase()
                                  .replaceAll(" ", ""));
                        },
                        itemBuilder: (cxt) => [
                          PopupMenuItem(
                            child: Text("Unilorin Su"),
                            value: "Unilorin Su",
                          ),
                          PopupMenuItem(
                            child: Text("Team Babs"),
                            value: "Team Babs",
                          ),
                          PopupMenuItem(
                            child: Text("Team Plato"),
                            value: "Team Plato",
                          ),
                        ],
                      )
                    ],
                  ),
                  Expanded(
                      child: LiquidPullToRefresh(
                    key: _refreshIndicatorKey,
                    color: ProbitasColor.ProbitasSecondary,
                    backgroundColor: ProbitasColor.ProbitasTextPrimary,
                    animSpeedFactor: 5,
                    showChildOpacityTransition: true,
                    onRefresh: () => ref
                        .watch(newsNotifierProvider.notifier)
                        .getMoreNews(source.toLowerCase().replaceAll(" ", "")),
                    child: Container(
                      width: context.screenWidth(),
                      child: Builder(builder: (context) {
                        if (newsNotifier.viewState.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: ProbitasColor.ProbitasSecondary,
                          ));
                        } else if (newsNotifier.viewState.isError) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListView(
                                shrinkWrap: true,
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        EmptyState(
                                          text: "Something went wrong!",
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        } else {
                          if (newsNotifier.news!.isNotEmpty) {
                            return NewsList(
                              controller: refreshController,
                              newsNotifier: newsNotifier,
                              source: source,
                              isDarkMode: isDarkMode,
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "No More News",
                                  style: Config.b3(context),
                                ),
                              ],
                            );
                          }
                        }
                      }),
                    ),
                  )),
                ],
              );
            },
          ),
        ));
  }
}

class NewsList extends HookConsumerWidget {
  const NewsList(
      {Key? key,
      required this.newsNotifier,
      required this.isDarkMode,
      required this.controller,
      required this.source})
      : super(key: key);

  final NewsState newsNotifier;
  final bool isDarkMode;
  final RefreshController controller;
  final String source;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    useEffect(() {
      void scrollListener() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          ref
              .read(newsNotifierProvider.notifier)
              .getMoreNews(source.toLowerCase().replaceAll(" ", ""));
        }
      }

      scrollController.addListener(scrollListener);

      return () => scrollController.removeListener(scrollListener);
    }, [scrollController]);

    return SmartRefresher(
      controller: controller,
      enablePullUp: true,
      enablePullDown: false,
      onRefresh: () => ref
          .read(newsNotifierProvider.notifier)
          .getNews(source.toLowerCase().replaceAll(" ", "")),
      child: ListView.builder(
          controller: scrollController,
          itemCount: newsNotifier.news!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == newsNotifier.news!.length - 1 &&
                newsNotifier.moreDataAvailable) {}

            return GestureDetector(
              onTap: () {
                NavigationService().navigateToScreen(
                    NewsOverview(url: newsNotifier.news![index].link!));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                width: context.screenWidth(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  border: Border.all(
                    color: isDarkMode
                        ? ProbitasColor.ProbitasTextPrimary
                        : ProbitasColor.ProbitasSecondary,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: source == 'Unilorin SU'
                                ? Image(
                                    fit: BoxFit.contain,
                                    image: AssetImage(ImagesAsset.news_default),
                                  )
                                : ClipOval(
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          newsNotifier.news![index].image!,
                                    ),
                                  ),
                          ),
                          XMargin(10.0),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  newsNotifier.news![index].title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Config.b3(context),
                                ),
                                Text(
                                  timeago.format(DateTime.parse(newsNotifier
                                      .news![index].date!
                                      .toString())),
                                  style: Config.b3(context).copyWith(
                                    color: isDarkMode
                                        ? ProbitasColor.ProbitasTextPrimary
                                        : ProbitasColor.ProbitasSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Container(
                          child: Text(
                            "${newsNotifier.news![index].excerpt} Read more",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Config.b3(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
