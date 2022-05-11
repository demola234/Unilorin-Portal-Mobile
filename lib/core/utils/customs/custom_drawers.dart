import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:probitas_app/core/utils/navigation_service.dart';
import 'package:probitas_app/features/profile/profile.dart';
import 'package:probitas_app/features/result/results.dart';
import 'package:probitas_app/features/settings/settings.dart';

import '../../../features/result/local_auth.dart';
import '../../constants/image_path.dart';
import '../config.dart';

class ProbitasDrawer extends StatelessWidget {
  const ProbitasDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      margin: const EdgeInsets.only(right: 30),
      child: Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Column(children: [
                    YMargin(15),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image(
                        width: 110,
                        height: 110,
                        fit: BoxFit.contain,
                        image: AssetImage(
                          ImagesAsset.default_image,
                        ),
                      ),
                    ),
                    YMargin(5),
                    Text(
                      "James Daniel",
                      style: Config.b3(context),
                    ),
                    YMargin(30),
                  ])),
                ],
              ),
              YMargin(10),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Column(children: [
                  DrawerListTile(
                    title: 'Profile',
                    onPressed: () {
                      NavigationService().goBack();
                      NavigationService().navigateToScreen(Profile());
                    },
                  ),
                  DrawerListTile(
                      title: 'Check Result',
                      onPressed: () async {
                        final isAuthenticated =
                            await LocalAuthApi.authenticate();

                        if (isAuthenticated) {
                        NavigationService().goBack();
                        NavigationService().navigateToScreen(Result());
                        }
                      }),
                  DrawerListTile(
                    title: 'Locate Theaters',
                    onPressed: () {
                      NavigationService().goBack();
                      // NavigationService().navigateToScreen(Profile());
                    },
                  ),
                  DrawerListTile(
                    title: 'Settings',
                    onPressed: () {
                      NavigationService().goBack();
                      NavigationService().navigateToScreen(Settings());
                    },
                  ),
                ]),
              ),
              Spacer(),
              YMargin(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  height: 40,
                  width: 137,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Log out",
                        style: Config.b3(context).copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ).ripple(() {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Container(),
                    ));
              }),
              YMargin(50),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const DrawerListTile({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
          onTap: onPressed,
          title: Text(
            title,
            style: Config.b2(context),
          )),
    );
  }
}

extension OnPressed on Widget {
  Widget ripple(Function onPressed,
          {BorderRadiusGeometry borderRadius =
              const BorderRadius.all(Radius.circular(5))}) =>
      Stack(
        children: <Widget>[
          this,
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: borderRadius),
                )),
                onPressed: () {
                  onPressed();
                },
                child: Container()),
          )
        ],
      );
}
