import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/config.dart';

import '../../../../core/utils/customs/custom_nav_bar.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
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
            title: const Text('Notifications'),
            value: notifications,
            onChanged: (bool value) {
              setState(() {
                notifications = value;
              });
            },
            secondary: SvgPicture.asset(ImagesAsset.notifications),
          )
        ],
      ),
    );
  }
}
