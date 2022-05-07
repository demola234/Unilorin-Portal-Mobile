import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/utils/config.dart';
import '../core/constants/image_path.dart';
import 'authentication/presentation/pages/assignments/assignment.dart';
import 'authentication/presentation/pages/dashboard/dashboard.dart';
import 'authentication/presentation/pages/messages/message.dart';
import 'authentication/presentation/pages/posts/posts.dart';
import 'authentication/presentation/pages/resources/resources.dart';

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
    return Scaffold(
        body: PageView(
          children: [
            DashBoard(),
            PostFeeds(),
            Assignment(),
            Messages(),
            Resources(),
          ],
          onPageChanged: onPageChanged,
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(ImagesAsset.home,
                  height: 20,
                  width: 20,
                  allowDrawingOutsideViewBox: true,
                  color: Colors.grey),
              label: "",
              tooltip: "Dashboard",
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    ImagesAsset.home,
                    height: 20,
                    width: 20,
                    allowDrawingOutsideViewBox: true,
                    color: ProbitasColor.ProbitasSecondry,
                  ),
                  YMargin(4.0),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ProbitasColor.ProbitasSecondry,
                    ),
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(ImagesAsset.post,
                  height: 20,
                  width: 20,
                  allowDrawingOutsideViewBox: true,
                  color: Colors.grey),
              label: "",
              tooltip: "Posts",
              activeIcon: Column(
                children: [
                  SvgPicture.asset(ImagesAsset.post,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: ProbitasColor.ProbitasSecondry),
                  YMargin(4.0),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ProbitasColor.ProbitasSecondry,
                    ),
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                ImagesAsset.resources,
                height: 20,
                width: 20,
                allowDrawingOutsideViewBox: true,
                color: Colors.grey,
              ),
              label: "",
              tooltip: "Tasks",
              activeIcon: Column(
                children: [
                  SvgPicture.asset(ImagesAsset.resources,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: ProbitasColor.ProbitasSecondry),
                  YMargin(4.0),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ProbitasColor.ProbitasSecondry,
                    ),
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                ImagesAsset.assignment,
                height: 20,
                width: 20,
                allowDrawingOutsideViewBox: true,
                color: Colors.grey,
              ),
              label: "",
              tooltip: "Resources",
              activeIcon: Column(
                children: [
                  SvgPicture.asset(ImagesAsset.assignment,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: ProbitasColor.ProbitasSecondry),
                  YMargin(4.0),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ProbitasColor.ProbitasSecondry,
                    ),
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                ImagesAsset.notifications,
                height: 20,
                width: 20,
                allowDrawingOutsideViewBox: true,
                color: Colors.grey,
              ),
              label: "",
              tooltip: "Notification",
              activeIcon: Column(
                children: [
                  SvgPicture.asset(ImagesAsset.notifications,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: ProbitasColor.ProbitasSecondry),
                  YMargin(4.0),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ProbitasColor.ProbitasSecondry,
                    ),
                  )
                ],
              ),
            ),
          ],
          selectedItemColor: ProbitasColor.ProbitasSecondry,
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
