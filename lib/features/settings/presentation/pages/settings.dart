import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/utils/customs/custom_nav_bar.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/image_viewer.dart';
import '../../../../core/utils/shimmer_loading.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';

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
        body: Column(
          children: [
            YMargin(25),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Consumer(
                      builder: ((context, ref, child) => Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ref.read(getUsersProvider).when(
                              data: (data) => GestureDetector(
                                    onTap: () {
                                      ImageViewUtils.showImagePreview(
                                          context, [data.data!.user!.avatar!]);
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
          ],
        ));
  }
}
