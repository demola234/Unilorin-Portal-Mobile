import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/utils/navigation_service.dart';
import 'package:probitas_app/core/utils/shimmer_loading.dart';
import 'package:probitas_app/features/authentication/presentation/pages/authentication/authentication.dart';
import 'package:probitas_app/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:probitas_app/features/locations/presentation/pages/location_screen.dart';
import 'package:probitas_app/features/profile/presentation/profile.dart';
import 'package:probitas_app/features/result/presentation/pages/results.dart';
import 'package:probitas_app/features/settings/presentation/pages/settings.dart';
import '../../../data/local/cache.dart';
import '../../../features/result/presentation/controller/local_auth.dart';
import '../config.dart';
import '../image_viewer.dart';

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
                            child: ref.read(getUsersProvider).when(
                                data: (data) => GestureDetector(
                                      onTap: () {
                                        ImageViewUtils.showImagePreview(context,
                                            [data.data!.user!.avatar!]);
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: data.data!.user!.avatar!,
                                        ),
                                      ),
                                    ),
                                error: (err, str) => Text("error"),
                                loading: () => Loading(
                                      width: 110,
                                      height: 110,
                                    ))))),
                    YMargin(10),
                    Consumer(
                      builder: ((context, watch, child) {
                        final response = watch.read(getUsersProvider);
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
                            loading: () => Loading(width: 100, height: 10));
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
                          NavigationService().navigateToScreen(Results());
                        }
                      }),
                  DrawerListTile(
                    title: 'Locate Places',
                    onPressed: () {
                      NavigationService().goBack();
                      NavigationService().navigateToScreen(Locations());
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

            YMargin(40),
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
                ).ripple(() {
                  Cache.get().clear();
                  NavigationService().replaceScreen(Authentication());
                }),
              ),
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
