import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/core/utils/customs/custom_drawers.dart';
import 'package:probitas_app/features/settings/presentation/pages/themes_setting.dart';
import '../../../../../../core/utils/customs/custom_nav_bar.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/image_viewer.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../core/utils/shimmer_loading.dart';
import '../../../../data/local/cache.dart';
import '../../../authentication/presentation/pages/authentication/authentication.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';
import 'notifications_settings.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: CustomNavBar(title: "Settings"),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(children: [
              YMargin(25),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Consumer(
                        builder: ((context, ref, child) => Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ref.read(getUsersProvider).when(
                                data: (data) => GestureDetector(
                                      onTap: () {
                                        ImageViewUtils.showImagePreview(context,
                                            [data.data!.user!.avatar!]);
                                      },
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: data.data!.user!.avatar!,
                                        ),
                                      ),
                                    ),
                                error: (err, str) => Text("error"),
                                loading: () => ClipOval(
                                      child: Loading(
                                        width: 110,
                                        height: 110,
                                      ),
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
                                  style: Config.b2(context).copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white
                                          : ProbitasColor.ProbitasPrimary),
                                ),
                            error: (err, st) => Text("error"),
                            loading: () => Loading(width: 100, height: 10));
                      }),
                    ),
                  ],
                ),
              ),
              YMargin(30),
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Users Preferences",
                          style: Config.h3(context).copyWith(
                            color: isDarkMode
                                ? ProbitasColor.ProbitasTextPrimary
                                : ProbitasColor.ProbitasPrimary,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    YMargin(15),
                    SettingsButton(
                      text: "Themes",
                    ).ripple(() {
                      NavigationService().navigateToScreen(ThemesMode());
                    }),
                    YMargin(15),
                    SettingsButton(
                      text: "Notifications",
                    ).ripple(() {
                      NavigationService().navigateToScreen(Notifications());
                    }),
                    YMargin(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Support",
                          style: Config.h3(context).copyWith(
                            color: isDarkMode
                                ? ProbitasColor.ProbitasTextPrimary
                                : ProbitasColor.ProbitasPrimary,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    YMargin(15),
                    SettingsButton(
                      text: "Contact Us",
                    ).ripple(() {
                      // NavigationService().navigateToScreen(Authentication());
                    }),
                    YMargin(15),
                    SettingsButton(
                      text: "FAQ",
                    ).ripple(() {
                      // NavigationService().navigateToScreen(Authentication());
                    }),
                    YMargin(45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 70,
                            width: context.screenWidth() / 2,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text("Log out",
                                      style: Config.b2(context).copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: ProbitasColor
                                              .ProbitasTextPrimary)),
                                ),
                              ],
                            )).ripple(() {
                          Cache.get().clear();
                          NavigationService().replaceScreen(Authentication());
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ])));
  }
}

class SettingsButton extends StatelessWidget {
  final String text;
  SettingsButton({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 70,
          width: context.screenWidth(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            border: Border.all(
              color: ProbitasColor.ProbitasTextPrimary.withOpacity(0.7),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text,
                  style: Config.b3(context).copyWith(
                    fontWeight: FontWeight.normal,
                    color: isDarkMode
                        ? ProbitasColor.ProbitasTextPrimary
                        : ProbitasColor.ProbitasPrimary,
                  )),
              Icon(
                Icons.arrow_forward_ios,
                size: 10,
              ),
            ],
          ),
        ));
  }
}
