import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/utils/config.dart';
import '../core/constants/image_path.dart';
import 'assignments/presentation/pages/assignment.dart';
import 'dashboard/presentation/pages/dashboard.dart';
import 'news/presentation/pages/news.dart';
import 'posts/presentation/pages/posts.dart';
import 'resources/presentation/pages/resources.dart';

class NavController extends StatefulWidget {
  const NavController({Key? key}) : super(key: key);

  @override
  _NavControllerState createState() => _NavControllerState();
}

class _NavControllerState extends State<NavController> {
  late PageController pageController;
  int _page = 0;

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        body: PageView(
          children: [
            Dashboard(),
            PostFeeds(),
            Resources(),
            Assignment(),
            News(),
          ],
          onPageChanged: onPageChanged,
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(ImagesAsset.home,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: Colors.grey),
                  YMargin(9.0),
                ],
              ),
              label: "",
              tooltip: "Dashboard",
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    ImagesAsset.home,
                    height: 20,
                    width: 20,
                    allowDrawingOutsideViewBox: true,
                    color: !isDarkMode
                        ? ProbitasColor.ProbitasSecondary
                        : ProbitasColor.ProbitasAccent,
                  ),
                  YMargin(4.0),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !isDarkMode
                          ? ProbitasColor.ProbitasSecondary
                          : ProbitasColor.ProbitasAccent,
                    ),
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(ImagesAsset.post,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: Colors.grey),
                  YMargin(9.0),
                ],
              ),
              label: "",
              tooltip: "Posts",
              activeIcon: Column(
                children: [
                  SvgPicture.asset(ImagesAsset.post,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: !isDarkMode
                          ? ProbitasColor.ProbitasSecondary
                          : ProbitasColor.ProbitasAccent),
                  YMargin(4.0),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !isDarkMode
                          ? ProbitasColor.ProbitasSecondary
                          : ProbitasColor.ProbitasAccent,
                    ),
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    ImagesAsset.resources,
                    height: 20,
                    width: 20,
                    allowDrawingOutsideViewBox: true,
                    color: Colors.grey,
                  ),
                  YMargin(9.0),
                ],
              ),
              label: "",
              tooltip: "Tasks",
              activeIcon: Column(
                children: [
                  SvgPicture.asset(ImagesAsset.resources,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: !isDarkMode
                          ? ProbitasColor.ProbitasSecondary
                          : ProbitasColor.ProbitasAccent),
                  YMargin(4.0),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !isDarkMode
                          ? ProbitasColor.ProbitasSecondary
                          : ProbitasColor.ProbitasAccent,
                    ),
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    ImagesAsset.assignment,
                    height: 20,
                    width: 20,
                    allowDrawingOutsideViewBox: true,
                    color: Colors.grey,
                  ),
                  YMargin(9.0),
                ],
              ),
              label: "",
              tooltip: "Resources",
              activeIcon: Column(
                children: [
                  SvgPicture.asset(ImagesAsset.assignment,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: !isDarkMode
                          ? ProbitasColor.ProbitasSecondary
                          : ProbitasColor.ProbitasAccent),
                  YMargin(4.0),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !isDarkMode
                          ? ProbitasColor.ProbitasSecondary
                          : ProbitasColor.ProbitasAccent,
                    ),
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    ImagesAsset.notifications,
                    height: 20,
                    width: 20,
                    allowDrawingOutsideViewBox: true,
                    color: Colors.grey,
                  ),
                  YMargin(9.0),
                ],
              ),
              label: "",
              tooltip: "Notification",
              activeIcon: Column(
                children: [
                  SvgPicture.asset(ImagesAsset.notifications,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: !isDarkMode
                          ? ProbitasColor.ProbitasSecondary
                          : ProbitasColor.ProbitasAccent),
                  YMargin(4.0),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !isDarkMode
                          ? ProbitasColor.ProbitasSecondary
                          : ProbitasColor.ProbitasAccent,
                    ),
                  )
                ],
              ),
            ),
          ],
          selectedItemColor: !isDarkMode
              ? ProbitasColor.ProbitasSecondary
              : ProbitasColor.ProbitasAccent,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: navigationTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: _page,
          iconSize: 20,
        ));
  }
}
