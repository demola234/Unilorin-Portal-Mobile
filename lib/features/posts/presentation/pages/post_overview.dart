import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_path.dart';
import '../../../../core/utils/components.dart';
import '../../../../core/utils/navigation_service.dart';

class PostOverView extends StatefulWidget {
  const PostOverView({Key? key}) : super(key: key);

  @override
  State<PostOverView> createState() => _PostOverViewState();
}

class _PostOverViewState extends State<PostOverView> {
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Posts"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YMargin(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Image(
                      image: AssetImage(ImagesAsset.default_image),
                    ),
                  ),
                  XMargin(5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Femi Ademola",
                          style: Config.b2(context)
                              .copyWith(color: ProbitasColor.ProbitasPrimary),
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
                            color: ProbitasColor.ProbitasTextSecondary),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Level 200",
                            style: Config.b2(context).copyWith(
                                color: ProbitasColor.ProbitasTextSecondary,
                                fontSize: 14.0)),
                        YMargin(2.0),
                        Text("Today, 02:34 PM",
                            style: Config.b2(context).copyWith(
                                color: ProbitasColor.ProbitasPrimary,
                                fontSize: 14.0))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Stack(
              children: [
                Container(
                  height: 220,
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
                //         activeDotColor: ProbitasColor.ProbitasSecondry,
                //         dotColor: ProbitasColor.ProbitasTextPrimary,
                //         dotHeight: 12,
                //         dotWidth: 12,
                //       ),
                //     ),
                //   ),
                // ),
                Divider(),
              ],
            ),
            YMargin(5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: Text(
                "In Flutter, the overflow property of the Text, RichText, and DefaultTextStyle widgets specifies how overflowed content that is not displayed should be signaled to the user. It can be clipped, display an ellipsis (three dots), fade, or overflowing outside its parent widget.",
                style: Config.b3(context).copyWith(
                    color: ProbitasColor.ProbitasPrimary, fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(ImagesAsset.liked,
                              height: 18, width: 18)),
                      XMargin(4),
                      Text(
                        "300",
                        style: Config.b3(context).copyWith(
                          color: ProbitasColor.ProbitasTextSecondary,
                        ),
                      ),
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
            ),
            Divider(),
            YMargin(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Add Comment",
                      textAlign: TextAlign.right,
                      style: Config.h3(context).copyWith(
                        fontSize: 19,
                      ),
                    ),
                  ),
                  YMargin(15),
                  ProbitasTextFormField(
                    hintText: "Write a comment",
                  ),
                  YMargin(20),
                  Container(
                    width: context.screenWidth(),
                    child: ListView.builder(
                      itemCount: 10,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: context.screenWidth(),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(
                                color: ProbitasColor.ProbitasTextPrimary,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                      child: Image(
                                        image: AssetImage(
                                            ImagesAsset.default_image),
                                      ),
                                    ),
                                    XMargin(5),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                          Text("Level 200",
                                              style: Config.b2(context).copyWith(
                                                  color: ProbitasColor
                                                      .ProbitasTextSecondary,
                                                  fontSize: 14.0)),
                                          YMargin(2.0),
                                          Text("Today, 02:34 PM",
                                              style: Config.b2(context)
                                                  .copyWith(
                                                      color: ProbitasColor
                                                          .ProbitasPrimary,
                                                      fontSize: 14.0))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Divider(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10.0),
                                  child: Text(
                                    "In Flutter, the overflosssssw property of the Text, RichText, and DefaultTextStyle widgets specifies how ",
                                    style: Config.b3(context).copyWith(
                                        color: ProbitasColor.ProbitasPrimary,
                                        fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {},
        child: Container(
          height: 70,
          width: 220,
          decoration: BoxDecoration(
              color: ProbitasColor.ProbitasSecondry,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Center(
            child: Text(
              "Add Comment",
              style: Config.b2(context).copyWith(
                color: ProbitasColor.ProbitasTextPrimary,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CustomNavBar extends StatelessWidget {
  CustomNavBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: Config.h3(context).copyWith(
          color: !isDarkMode ? ProbitasColor.ProbitasPrimary : Colors.white,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImagesAsset.top_background),
                fit: BoxFit.cover)),
      ),
      leadingWidth: 80,
      leading: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: GestureDetector(
          onTap: () {
            NavigationService().goBack();
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                border: Border.all()),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
