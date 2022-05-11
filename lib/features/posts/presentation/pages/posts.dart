import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:probitas_app/features/posts/presentation/pages/add_post.dart';
import 'package:probitas_app/features/posts/presentation/pages/post_overview.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_path.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_appbar.dart';
import '../../../../core/utils/customs/custom_drawers.dart';
import '../../../../core/utils/navigation_service.dart';

class PostFeeds extends StatefulWidget {
  const PostFeeds({Key? key}) : super(key: key);

  @override
  State<PostFeeds> createState() => _PostFeedsState();
}

class _PostFeedsState extends State<PostFeeds> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  late PageController controller;
  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  "Posts",
                  style: Config.h3(context).copyWith(
                    color: ProbitasColor.ProbitasPrimary,
                    fontSize: 18,
                  ),
                ),
                ProbitasSmallButton(
                    title: "Add Posts",
                    onTap: () =>
                        NavigationService().navigateToScreen(AddPost()))
              ],
            ),
            YMargin(10),
            Expanded(
              child: Container(
                height: context.screenHeight(),
                width: context.screenWidth(),
                child: ListView.builder(
                  itemCount: 200,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        NavigationService().navigateToScreen(PostOverView());
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        width: context.screenWidth(),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            border: Border.all(
                              color:
                                  ProbitasColor.ProbitasTextPrimary.withOpacity(
                                      0.7),
                            )),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                    child: Image(
                                      image:
                                          AssetImage(ImagesAsset.default_image),
                                    ),
                                  ),
                                  XMargin(10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Femi Ademola",
                                          style: Config.b2(context).copyWith(
                                              color: ProbitasColor
                                                  .ProbitasPrimary),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      YMargin(2.0),
                                      Text(
                                        "Microbiology",
                                        style: Config.b2(context).copyWith(
                                            color: ProbitasColor
                                                .ProbitasTextSecondary),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                            onTap: () {},
                                            child: Icon(
                                              Icons.more_vert,
                                              color: ProbitasColor
                                                  .ProbitasTextSecondary,
                                            )),
                                        YMargin(2.0),
                                        Text("Level 200",
                                            style: Config.b2(context).copyWith(
                                                color: ProbitasColor
                                                    .ProbitasTextSecondary,
                                                fontSize: 14.0))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            index % 3 == 0
                                ? Stack(
                                    children: [
                                      Container(
                                        height: 160,
                                        width: context.screenWidth(),
                                        child: PageView.builder(
                                          controller: controller,
                                          physics: BouncingScrollPhysics(),
                                          onPageChanged: (int index) {
                                            setState(() {
                                              currentIndex = index;
                                            });
                                          },
                                          itemCount: 3,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              decoration: BoxDecoration(),
                                              child: Image(
                                                image: AssetImage(
                                                  ImagesAsset.post_default,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      // Positioned.fill(
                                      //   bottom: 8.0,
                                      //   child: Align(
                                      //     alignment: Alignment.bottomCenter,
                                      //     child: SmoothPageIndicator(
                                      //       controller: controller,
                                      //       count: currentIndex,
                                      //       effect: ScrollingDotsEffect(
                                      //         activeStrokeWidth: 2.6,
                                      //         activeDotScale: 1.3,
                                      //         maxVisibleDots: 5,
                                      //         radius: 8,
                                      //         spacing: 10,
                                      //         activeDotColor:
                                      //             ProbitasColor.ProbitasSecondry,
                                      //         dotColor:
                                      //             ProbitasColor.ProbitasTextPrimary,
                                      //         dotHeight: 12,
                                      //         dotWidth: 12,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      Divider(),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10.0),
                              child: ReadMoreText(
                                "In Flutter, the overflow property of the Text, RichText, and DefaultTextStyle widgets specifies how overflowed content that is not displayed should be signaled to the user. It can be clipped, display an ellipsis (three dots), fade, or overflowing outside its parent widget.",
                                style: Config.b3(context).copyWith(
                                    color: ProbitasColor.ProbitasPrimary,
                                    fontSize: 14.0),
                                trimLines: 3,
                                delimiter: "...",
                                colorClickableText:
                                    ProbitasColor.ProbitasSecondry,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Read More',
                                trimExpandedText: 'Close',
                                lessStyle: Config.b2(context).copyWith(
                                    color: ProbitasColor.ProbitasSecondry,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                                moreStyle: Config.b2(context).copyWith(
                                  color: ProbitasColor.ProbitasSecondry,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            YMargin(2.0),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {},
                                          child: SvgPicture.asset(
                                              index % 3 == 0
                                                  ? ImagesAsset.liked
                                                  : ImagesAsset.notliked,
                                              height: 18,
                                              width: 18)),
                                      XMargin(4),
                                      Text(
                                        "2",
                                        style: Config.b3(context).copyWith(
                                          color: ProbitasColor
                                              .ProbitasTextSecondary,
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
                                              width: 18)),
                                      XMargin(4),
                                      Text("20",
                                          style: Config.b3(context).copyWith(
                                            color: ProbitasColor
                                                .ProbitasTextSecondary,
                                          )),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    tooltip: "Share",
                                    icon: SvgPicture.asset(ImagesAsset.share,
                                        height: 18, width: 18),
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
              ),
            )
          ],
        ),
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
              color: ProbitasColor.ProbitasSecondry,
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
