import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:probitas_app/core/utils/config.dart';

import '../../constants/colors.dart';
import '../../constants/image_path.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Container(
        width: context.screenWidth(),
        height: 25,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(!isDarkMode
                    ? ImagesAsset.logo_light
                    : ImagesAsset.logo_dark))),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImagesAsset.top_background),
                fit: BoxFit.cover)),
      ),
      leading: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          ImagesAsset.drawer,
          height: 25,
          width: 25,
          color: !isDarkMode ? ProbitasColor.ProbitasPrimary : Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            ImagesAsset.notifications,
            height: 25,
            width: 25,
            color: !isDarkMode ? ProbitasColor.ProbitasPrimary : Colors.white,
          ),
        ),
      ],
    );
  }
}
