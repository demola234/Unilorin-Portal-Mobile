import 'package:flutter/material.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/utils/config.dart';

import '../../../../core/utils/customs/custom_nav_bar.dart';

class ThemesMode extends StatefulWidget {
  const ThemesMode({Key? key}) : super(key: key);

  @override
  State<ThemesMode> createState() => _ThemeModeState();
}

class _ThemeModeState extends State<ThemesMode> {
  String? theme = "system";
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: CustomNavBar(title: "Themes"),
        ),
        body: Column(
          children: [
            YMargin(20),
            ListTile(
              title: Text("System Preferences"),
              leading: Radio(
                  activeColor: isDarkMode
                      ? ProbitasColor.ProbitasTextPrimary
                      : ProbitasColor.ProbitasSecondary,
                  value: "system",
                  groupValue: theme,
                  onChanged: (value) {
                    setState(() {
                      theme = value.toString();
                    });
                  }),
            ),
            YMargin(10),
            ListTile(
              title: Text("Light Mode"),
              leading: Radio(
                  activeColor: ProbitasColor.ProbitasSecondary,
                  value: "light",
                  groupValue: theme,
                  onChanged: (value) {}),
            ),
            YMargin(10),
            ListTile(
              title: Text("Dark Mode"),
              leading: Radio(
                  activeColor: ProbitasColor.ProbitasSecondary,
                  value: "dark",
                  groupValue: theme,
                  onChanged: (value) {}),
            ),
          ],
        ));
  }
}
