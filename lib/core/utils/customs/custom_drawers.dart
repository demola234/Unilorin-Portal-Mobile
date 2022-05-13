import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/utils/navigation_service.dart';
import 'package:probitas_app/features/dashboard/presentation/controller/dashboard_controller.dart';
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      margin: const EdgeInsets.only(right: 30),
      child: Drawer(
        backgroundColor:
            isDarkMode ? ProbitasColor.ProbitasPrimary : Colors.white,
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
                    Consumer(
                        builder: ((context, ref, child) => Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ref.read(getUsers).when(
                                  data: (data) => CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    imageUrl: data.data!.user!.avatar!,
                                  ),
                                  error: (err, str) => Text("error"),
                                  loading: () => Text("loading"),
                                )))),
                    YMargin(5),
                    Consumer(
                      builder: ((context, watch, child) {
                        final response = watch.read(getUsers);
                        return response.when(
                            data: (response) => Text(
                                  "${response.data!.user!.fullName!}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Config.b3(context).copyWith(
                                      color: isDarkMode
                                          ? Colors.white
                                          : ProbitasColor.ProbitasPrimary),
                                ),
                            error: (err, st) => Text("error"),
                            loading: () => Text("loading..."));
                      }),
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
