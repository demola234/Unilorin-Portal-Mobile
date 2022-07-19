import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/config.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    bool notifications = false;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Notification"),
      ),
      body: Column(
        children: [
          YMargin(20),
          SwitchListTile(
            title: Text('Notifications',
                style: Config.b1(context).copyWith(
                    color: isDarkMode
                        ? ProbitasColor.ProbitasTextPrimary
                        : ProbitasColor.ProbitasSecondary)),
            value: notifications,
            onChanged: (bool value) {
              setState(() {
                notifications = value;
              });
            },
            secondary: SvgPicture.asset(ImagesAsset.notifications,
                color: isDarkMode
                    ? ProbitasColor.ProbitasTextPrimary
                    : ProbitasColor.ProbitasSecondary),
          )
        ],
      ),
    );
  }
}
