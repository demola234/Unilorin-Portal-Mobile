import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'package:probitas_app/features/authentication/data/model/onboarding_model.dart';

import '../authentication/authentication.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -40,
            child: Image.asset(ImagesAsset.top_background),
          ),
          Positioned(
            top: 80,
            child: Container(
              width: context.screenWidth(),
              height: 25,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(!isDarkMode
                          ? ImagesAsset.logo_light
                          : ImagesAsset.logo_dark))),
            ),
          ),
          PageView.builder(
              itemCount: onboarding.length,
              controller: _pageController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, index) {
                return Column(children: [
                  YMargin(220),
                  Column(children: [
                    Lottie.asset(
                      onboarding[index].img,
                      height: 325,
                      width: 325,
                      animate: true,
                      repeat: false,
                    ),
                    YMargin(20),
                    Container(
                        width: context.screenWidth() - 50,
                        height: 103,
                        decoration: BoxDecoration(
                            color: Color(0xFFE3D6C5).withOpacity(0.3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.5))),
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(onboarding[index].desc,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat()),
                          ),
                        ))
                  ]),
                ]);
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 180.0),
              child: Container(
                height: 10.0,
                child: ListView.builder(
                  itemCount: onboarding.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.0),
                            width: currentIndex == index ? 21 : 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? !isDarkMode
                                      ? Color(0xFF1A1A2A)
                                      : Color(0xFFD8ECEA)
                                  : Color(0xFFE3D6C5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ]);
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60.0),
              child: Container(
                child: InkWell(
                  onTap: () async {
                    if (currentIndex == onboarding.length - 1) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Authentication()));
                    }
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    height: 72,
                    width: context.screenWidth(),
                    decoration: BoxDecoration(
                        color:
                            !isDarkMode ? Color(0xFF045257) : Color(0xFFD8ECEA),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Continue to login",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                            color: !isDarkMode
                                ? Color(0xFFE3D6C5)
                                : Color(0xFF1A1A2A),
                          ),
                        )),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
