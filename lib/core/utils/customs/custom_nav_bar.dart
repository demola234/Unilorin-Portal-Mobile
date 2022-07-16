import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/image_path.dart';
import '../config.dart';
import '../navigation_service.dart';

class CustomNavBar extends StatelessWidget {
  CustomNavBar({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String title;
  void Function()? onTap;
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
            fit: BoxFit.cover,
          ),
        ),
      ),
      leadingWidth: 80,
      leading: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: GestureDetector(
          onTap: () {
            NavigationService().goBack();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                border: Border.all(
                  color:
                      isDarkMode ? Colors.white : ProbitasColor.ProbitasPrimary,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: isDarkMode
                          ? Colors.white
                          : ProbitasColor.ProbitasPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
