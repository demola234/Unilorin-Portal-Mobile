import 'package:flutter/material.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Settings"),
      ),
    );
  }
}
