import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/navigation_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_appbar.dart';
import '../../../../core/utils/customs/custom_drawers.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../controller/news_controller.dart';
import '../provider/news_provider.dart';
import 'news_overview.dart';

class Messages extends ConsumerWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  final scrollController = ScrollController();
  final refreshController = RefreshController();

  Future<void> _handleRefresh() async {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paginationState = ref.watch(newsNotifierProvider.notifier).state;
    final paginationController = ref.watch(newsNotifierProvider.notifier);
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
          child: Column(
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
                ],
              ),
              Expanded(
                  child: LiquidPullToRefresh(
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  return await ref.refresh(newsNotifierProvider);
                },
                color: Color(0xFF045257),
                backgroundColor: ProbitasColor.ProbitasTextPrimary,
                animSpeedFactor: 5,
                showChildOpacityTransition: true,
                child: SmartRefresher(
                    controller: refreshController,
                    enablePullDown: false,
                    enablePullUp: true,
                    onRefresh: () async {
                      return ref.refresh(newsNotifierProvider);
                    },
                    child: Container(
                      width: context.screenWidth(),
                      child: Builder(builder: (context) {
                        if (paginationState.error.isNotEmpty) {
                          return Center(
                            child: ListView(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(child: Text("err")),
                                ],
                              )
                            ]),
                          );
                        } else if (paginationState.news.isEmpty) {
                          Center(
                            child: CircularProgressIndicator(
                                color: ProbitasColor.ProbitasSecondary),
                          );
                        }
                        return ListView.builder(
                            controller: scrollController,
                            itemCount: paginationState.news.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              paginationController.handleScrollWithIndex(index);
                              return GestureDetector(
                                onTap: () {
                                  NavigationService().navigateToScreen(
                                      NewsOverview(
                                          url: paginationState
                                              .news[index].link!));
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
                                                child: Image(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(
                                                      ImagesAsset.news_default),
                                                )),
                                            XMargin(10.0),
                                            Flexible(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    paginationState
                                                        .news[index].title!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Config.b3(context),
                                                  ),
                                                  Text(
                                                    timeago.format(
                                                        DateTime.parse(
                                                            paginationState
                                                                .news[index]
                                                                .date!
                                                                .toString())),
                                                    style: Config.b3(context)
                                                        .copyWith(
                                                      color: isDarkMode
                                                          ? ProbitasColor
                                                              .ProbitasTextPrimary
                                                          : ProbitasColor
                                                              .ProbitasSecondary,
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
                                          child: Text(
                                            "${paginationState.news[index].excerpt} Read more",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Config.b3(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                    )),
              )),
            ],
          ),
        ));
  }
}
