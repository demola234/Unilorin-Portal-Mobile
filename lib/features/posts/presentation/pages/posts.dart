import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:probitas_app/core/utils/states.dart';
import 'package:probitas_app/features/dashboard/presentation/widget/empty_state/empty_state.dart';
import 'package:probitas_app/features/posts/presentation/pages/add_post.dart';
import 'package:probitas_app/features/posts/presentation/pages/post_overview.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_path.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_appbar.dart';
import '../../../../core/utils/customs/custom_drawers.dart';
import '../../../../core/utils/image_viewer.dart';
import '../../../../core/utils/navigation_service.dart';
import '../controller/post_controller.dart';
import '../provider/post_provider.dart';

class PostFeeds extends StatefulHookConsumerWidget {
  const PostFeeds({Key? key}) : super(key: key);

  @override
  ConsumerState<PostFeeds> createState() => _PostFeedsState();
}

class _PostFeedsState extends ConsumerState<PostFeeds> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  final scrollController = ScrollController();
  final refreshController = RefreshController();

  var controller = PageController();
  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Consumer(builder: (context, ref, child) {
          final postsNotifier = ref.watch(postsNotifierProvider);
          return Column(
            children: [
              YMargin(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Posts",
                    style: Config.h3(context).copyWith(
                      color: isDarkMode
                          ? ProbitasColor.ProbitasTextPrimary
                          : ProbitasColor.ProbitasPrimary,
                      fontSize: 18,
                    ),
                  ),
                  ProbitasSmallButton(
                      title: "Add Post",
                      onTap: () =>
                          NavigationService().navigateToScreen(AddPost()))
                ],
              ),
              YMargin(10),
              Expanded(
                child: Container(
                  width: context.screenWidth(),
                  child: LiquidPullToRefresh(
                      key: _refreshIndicatorKey,
                      onRefresh: () =>
                          ref.watch(postsNotifierProvider.notifier).getPosts(),
                      color: ProbitasColor.ProbitasSecondary,
                      backgroundColor: ProbitasColor.ProbitasTextPrimary,
                      animSpeedFactor: 5,
                      showChildOpacityTransition: true,
                      child: Container(
                        width: context.screenWidth(),
                        child: Builder(builder: (context) {
                          if (postsNotifier.viewState.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: ProbitasColor.ProbitasSecondary,
                            ));
                          } else if (postsNotifier.viewState.isError) {
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
                            if (postsNotifier.posts!.isNotEmpty) {
                              return PostsList(
                                  controller: refreshController,
                                  postsNotifier: postsNotifier,
                                  isDarkMode: isDarkMode);
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
                      )),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class ProbitasSmallButton extends StatelessWidget {
  ProbitasSmallButton({
    Key? key,
    this.onTap,
    this.icon,
    required this.title,
  }) : super(key: key);
  final void Function()? onTap;
  final String? icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 35,
          width: 90,
          decoration: BoxDecoration(
              color: ProbitasColor.ProbitasSecondary,
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null ? SvgPicture.asset(icon!) : Container(),
              icon != null ? XMargin(2) : XMargin(0),
              Text(title,
                  style: Config.b3(context).copyWith(
                    color: ProbitasColor.ProbitasTextPrimary,
                  )),
            ],
          )),
        ),
      ),
    );
  }
}

class PostsList extends HookConsumerWidget {
  PostsList({
    Key? key,
    required this.postsNotifier,
    required this.isDarkMode,
    required this.controller,
  }) : super(key: key);

  final PostsState postsNotifier;
  final bool isDarkMode;
  final RefreshController controller;
  var pageController = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final scrollController = useScrollController();
    useEffect(() {
      void scrollListener() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          ref.read(postsNotifierProvider.notifier).getMorePosts();
        }
      }

      scrollController.addListener(scrollListener);

      return () => scrollController.removeListener(scrollListener);
    }, [scrollController]);

    return SmartRefresher(
      controller: controller,
      enablePullUp: true,
      enablePullDown: false,
      onRefresh: () {
        ref.read(postsNotifierProvider.notifier).getPosts();
      },
      child: ListView.builder(
        controller: scrollController,
        itemCount: postsNotifier.posts!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == postsNotifier.posts!.length - 1 &&
              postsNotifier.moreDataAvailable) {}
          return GestureDetector(
            onTap: () {
              print(postsNotifier.posts![index].images!.length);
              NavigationService().navigateToScreen(
                  PostOverView(singlePostId: postsNotifier.posts![index].id!));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: context.screenWidth(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                border: Border.all(
                  color: ProbitasColor.ProbitasTextPrimary.withOpacity(0.7),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ImageViewUtils.showImagePreview(context,
                                [postsNotifier.posts![index].user!.avatar!]);
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.fitWidth,
                                imageUrl:
                                    postsNotifier.posts![index].user!.avatar!,
                              ),
                            ),
                          ),
                        ),
                        XMargin(10),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 400,
                                child: Text(
                                  "${postsNotifier.posts![index].user!.fullName!.split(" ")[1]} ${postsNotifier.posts![index].user!.fullName!.split(" ").first[0].toUpperCase()} . ${postsNotifier.posts![index].user!.fullName!.split(" ").last[0].toUpperCase()}",
                                  style: Config.b2(context).copyWith(
                                      color: isDarkMode
                                          ? ProbitasColor.ProbitasTextPrimary
                                          : ProbitasColor.ProbitasPrimary),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              YMargin(2.0),
                              Text(
                                postsNotifier.posts![index].user!.department!
                                    .toString(),
                                style: Config.b2(context).copyWith(
                                  color: isDarkMode
                                      ? ProbitasColor.ProbitasTextPrimary
                                          .withOpacity(0.5)
                                      : ProbitasColor.ProbitasTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            PopupMenuButton(
                              child: Icon(
                                Icons.more_vert,
                                color: isDarkMode
                                    ? ProbitasColor.ProbitasTextPrimary
                                    : ProbitasColor.ProbitasPrimary,
                              ),
                              onSelected: (selectedValue) {
                                print(selectedValue);
                              },
                              itemBuilder: (BuildContext ctx) => [
                                PopupMenuItem(
                                    child: Text('Delete'), value: '1'),
                              ],
                            ),
                            YMargin(2.0),
                            Text(
                              "${postsNotifier.posts![index].user!.level!} Level",
                              style: Config.b2(context).copyWith(
                                color: isDarkMode
                                    ? ProbitasColor.ProbitasTextPrimary
                                        .withOpacity(0.5)
                                    : ProbitasColor.ProbitasTextSecondary,
                                fontSize: 14.0,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: isDarkMode
                        ? ProbitasColor.ProbitasTextPrimary.withOpacity(0.5)
                        : ProbitasColor.ProbitasTextSecondary,
                  ),
                  postsNotifier.posts![index].images!.isNotEmpty
                      ? Stack(
                          children: [
                            Container(
                                height: 220,
                                width: context.screenWidth(),
                                child: PageView.builder(
                                  controller: pageController,
                                  physics: BouncingScrollPhysics(),
                                  onPageChanged: (int index) {},
                                  itemCount: postsNotifier
                                      .posts![index].images!.length,
                                  itemBuilder: (context, imageIndex) {
                                    return GestureDetector(
                                      onTap: () {
                                        ImageViewUtils.showImagePreview(
                                            context, [
                                          postsNotifier
                                              .posts![index].images![imageIndex]
                                        ]);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(),
                                        child: CachedNetworkImage(
                                          imageUrl: postsNotifier.posts![index]
                                              .images![imageIndex],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                )),
                            postsNotifier.posts![index].images!.length > 1
                                ? Positioned.fill(
                                    bottom: 8.0,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SmoothPageIndicator(
                                        controller: pageController,
                                        count: postsNotifier
                                            .posts![index].images!.length,
                                        effect: JumpingDotEffect(
                                          activeDotColor:
                                              ProbitasColor.ProbitasSecondary,
                                          dotHeight: 10,
                                          dotWidth: 10,
                                          jumpScale: .7,
                                          verticalOffset: 15,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                            Divider(),
                          ],
                        )
                      : SizedBox.shrink(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: ReadMoreText(
                        "${postsNotifier.posts![index].text}",
                        style: Config.b3(context).copyWith(fontSize: 14.0),
                        textAlign: TextAlign.right,
                        trimLines: 3,
                        delimiter: "...",
                        colorClickableText: isDarkMode
                            ? ProbitasColor.ProbitasTextPrimary
                            : ProbitasColor.ProbitasPrimary,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Read More',
                        trimExpandedText: 'Close',
                        lessStyle: Config.b2(context).copyWith(
                            color: isDarkMode
                                ? ProbitasColor.ProbitasTextPrimary
                                : ProbitasColor.ProbitasSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                        moreStyle: Config.b2(context).copyWith(
                          color: isDarkMode
                              ? ProbitasColor.ProbitasTextPrimary
                              : ProbitasColor.ProbitasSecondary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  YMargin(2.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  ref
                                      .watch(postsNotifierProvider.notifier)
                                      .likedOrUnlike(
                                          postsNotifier.posts![index].id!,
                                          true);

                                  ref
                                      .refresh(postsNotifierProvider.notifier)
                                      .getPosts();
                                },
                                child: postsNotifier.posts![index].isUserLiked!
                                    ? SvgPicture.asset(ImagesAsset.liked,
                                        height: 18, width: 18)
                                    : SvgPicture.asset(
                                        ImagesAsset.notliked,
                                        height: 18,
                                        width: 18,
                                        color: isDarkMode
                                            ? ProbitasColor.ProbitasTextPrimary
                                            : ProbitasColor
                                                .ProbitasTextSecondary,
                                      )),
                            XMargin(4),
                            Text(
                              "${postsNotifier.posts![index].likeCount}",
                              style: Config.b3(context).copyWith(
                                color: isDarkMode
                                    ? ProbitasColor.ProbitasTextPrimary
                                    : ProbitasColor.ProbitasTextSecondary,
                              ),
                            ),
                          ],
                        ),
                        XMargin(20),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {},
                                child: SvgPicture.asset(
                                  ImagesAsset.chat,
                                  height: 18,
                                  width: 18,
                                  color: isDarkMode
                                      ? ProbitasColor.ProbitasTextPrimary
                                      : ProbitasColor.ProbitasPrimary,
                                )),
                            XMargin(4),
                            Text(
                              "${postsNotifier.posts![index].commentCount}",
                              style: Config.b3(context).copyWith(
                                  color: isDarkMode
                                      ? ProbitasColor.ProbitasTextPrimary
                                      : ProbitasColor.ProbitasTextSecondary),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Share.share("${postsNotifier.posts![index].text}");
                          },
                          tooltip: "Share",
                          icon: SvgPicture.asset(ImagesAsset.share,
                              color: isDarkMode
                                  ? ProbitasColor.ProbitasTextPrimary
                                  : ProbitasColor.ProbitasPrimary,
                              height: 18,
                              width: 18),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
