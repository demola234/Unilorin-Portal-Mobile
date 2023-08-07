import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'package:probitas_app/features/dashboard/presentation/controller/dashboard_controller.dart';
import '../../../core/constants/colors.dart';
import '../../../../../core/utils/customs/custom_nav_bar.dart';
import '../../../core/utils/customs/custom_error.dart';
import '../../../core/utils/image_viewer.dart';

class Profile extends ConsumerWidget {
  Profile({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(getUserProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Profile"),
      ),
      body: value.when(
          data: (data) => Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 100,
                    width: context.screenWidth(),
                    decoration: BoxDecoration(
                      color: ProbitasColor.ProbitasTextPrimary.withOpacity(0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              Container(
                                  width: 60,
                                  height: 60,
                                  child: GestureDetector(
                                    onTap: () {
                                      ImageViewUtils.showImagePreview(
                                          context, [data.data!.user!.avatar!]);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fitWidth,
                                        imageUrl: data.data!.user!.avatar!,
                                      ),
                                    ),
                                  )),
                              XMargin(20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.data!.user!.fullName!,
                                    maxLines: 1,
                                    style: Config.b2(context).copyWith(
                                        color: isDarkMode
                                            ? Colors.white
                                            : ProbitasColor.ProbitasPrimary),
                                  ),
                                  YMargin(2.0),
                                  Text(
                                    "${data.data!.user!.level} Level",
                                    style: Config.b2(context).copyWith(
                                        color: isDarkMode
                                            ? ProbitasColor.ProbitasTextPrimary
                                            : ProbitasColor
                                                .ProbitasTextSecondary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  YMargin(20),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Text(
                            "Your Details",
                            style: Config.h3(context).copyWith(
                              fontSize: 19,
                            ),
                          ),
                          YMargin(10),
                          Divider(),
                          YMargin(10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 6.0,
                                height: 330,
                                decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? ProbitasColor.ProbitasTextSecondary
                                        : ProbitasColor.ProbitasSecondary,
                                    borderRadius: BorderRadius.circular(12.0)),
                              ),
                              XMargin(15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  YMargin(5.0),
                                  Text(
                                    "Full Name: ${data.data!.user!.fullName}",
                                    style: Config.b2(context),
                                  ),
                                  YMargin(5),
                                  Text(
                                    "Sex: ${data.data!.user!.gender}",
                                    style: Config.b2(context),
                                  ),
                                  YMargin(5),
                                  Text(
                                    "Current Session: ${data.data!.user!.semester!.session}",
                                    style: Config.b2(context),
                                  ),
                                  YMargin(5),
                                  Text(
                                    "Phone Number: ${data.data!.user!.phoneNumber}",
                                    style: Config.b2(context),
                                  ),
                                  YMargin(5),
                                  Container(
                                    width: context.screenWidth() - 70,
                                    child: Text(
                                      "Faculty: ${data.data!.user!.faculty}",
                                      style: Config.b2(context),
                                    ),
                                  ),
                                  YMargin(5),
                                  Text(
                                    "Department: ${data.data!.user!.department}",
                                    style: Config.b2(context),
                                  ),
                                  YMargin(5),
                                  Text(
                                    "Programme: ${data.data!.user!.course}",
                                    style: Config.b2(context),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  YMargin(5),
                                  Text(
                                    "Studentship Status: ${data.data!.user!.studentShipStatus}",
                                    style: Config.b2(context),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  YMargin(5),
                                  Text(
                                    "Charges Paid: ${data.data!.user!.chargesPaid}",
                                    style: Config.b2(context),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  YMargin(5),
                                  Text(
                                    "Mode Of Entry: ${data.data!.user!.modeOfEntry}",
                                    style: Config.b2(context),
                                  ),
                                  YMargin(5),
                                  Container(
                                    width: context.screenWidth() - 70,
                                    child: Text(
                                      "Studentship Email: ${data.data!.user!.studentEmail}",
                                      style: Config.b2(context),
                                    ),
                                  ),
                                  YMargin(5),
                                  Container(
                                    width: context.screenWidth() - 70,
                                    child: Text(
                                      "Permanent/Home Address: ${data.data!.user!.address}",
                                      style: Config.b2(context),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          YMargin(30),
                          Text(
                            "Your Level Adviser Details",
                            style: Config.h3(context).copyWith(
                              fontSize: 19,
                            ),
                          ),
                          YMargin(10),
                          Divider(),
                          YMargin(10),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 6.0,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? ProbitasColor.ProbitasTextSecondary
                                          : ProbitasColor.ProbitasSecondary,
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                ),
                                XMargin(15),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      YMargin(5.0),
                                      Container(
                                        width: context.screenWidth() / 1.5,
                                        child: Text(
                                          "Full Name: ${data.data!.user!.levelAdviser!.fullName}",
                                          style: Config.b2(context),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      YMargin(5),
                                      // Text(
                                      //   "Phone Number: 0712929292",
                                      //   style: Config.b2(context),
                                      // ),
                                      Container(
                                        width: context.screenWidth() / 1.4,
                                        child: Text(
                                          "Phone Number: ${data.data!.user!.levelAdviser!.phoneNumber}",
                                          style: Config.b2(context),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      YMargin(5),

                                      Container(
                                        width: context.screenWidth() / 1.5,
                                        child: Text(
                                          "Email: ${data.data!.user!.levelAdviser!.email}",
                                          style: Config.b2(context),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ])
                              ]),
                          YMargin(30),
                          Text(
                            "Your Next Of Kin Details",
                            style: Config.h3(context).copyWith(
                              fontSize: 19,
                            ),
                          ),
                          YMargin(10),
                          Divider(),
                          YMargin(10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 6.0,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? ProbitasColor.ProbitasTextSecondary
                                        : ProbitasColor.ProbitasSecondary,
                                    borderRadius: BorderRadius.circular(12.0)),
                              ),
                              XMargin(15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  YMargin(5.0),
                                  Container(
                                    width: context.screenWidth() / 1.5,
                                    child: Text(
                                      "Full Name: ${data.data!.user!.nextOfKin!.fullName}",
                                      style: Config.b2(context),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  YMargin(5.0),
                                  Container(
                                    width: context.screenWidth() - 70,
                                    child: Text(
                                      "Address: ${data.data!.user!.nextOfKin!.address}",
                                      style: Config.b2(context),
                                    ),
                                  ),
                                  YMargin(5),
                                  Container(
                                    width: context.screenWidth() / 1.4,
                                    child: Text(
                                      "Relationship: ${data.data!.user!.nextOfKin!.relationship}",
                                      style: Config.b2(context),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  YMargin(5),
                                  Container(
                                    width: context.screenWidth() / 1.4,
                                    child: Text(
                                      "Phone Number: ${data.data!.user!.nextOfKin!.phoneNumber}",
                                      style: Config.b2(context),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  YMargin(5),
                                  Container(
                                    width: context.screenWidth() / 1.5,
                                    child: Text(
                                      "Email: ${data.data!.user!.nextOfKin!.email}",
                                      style: Config.b2(context),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          YMargin(30),
                          Text(
                            "Your Guardian Details",
                            style: Config.h3(context).copyWith(
                              fontSize: 19,
                            ),
                          ),
                          YMargin(10),
                          Divider(),
                          YMargin(10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 6.0,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? ProbitasColor.ProbitasTextSecondary
                                        : ProbitasColor.ProbitasSecondary,
                                    borderRadius: BorderRadius.circular(12.0)),
                              ),
                              XMargin(15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  YMargin(5.0),
                                  Container(
                                    width: context.screenWidth() / 1.5,
                                    child: Text(
                                      "Full Name: ${data.data!.user!.guardian!.fullName}",
                                      style: Config.b2(context),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  YMargin(5.0),
                                  Container(
                                    width: context.screenWidth() - 70,
                                    child: Text(
                                      "Address: ${data.data!.user!.guardian!.address}",
                                      style: Config.b2(context),
                                    ),
                                  ),
                                  YMargin(5),
                                  Container(
                                    width: context.screenWidth() / 1.4,
                                    child: Text(
                                      "Phone Number: ${data.data!.user!.guardian!.phoneNumber}",
                                      style: Config.b2(context),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  YMargin(5),
                                  Container(
                                    width: context.screenWidth() / 1.5,
                                    child: Text(
                                      "Email: ${data.data!.user!.guardian!.email}",
                                      style: Config.b2(context),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          YMargin(30),
                          Text(
                            "Your Sponsor Details",
                            style: Config.h3(context).copyWith(
                              fontSize: 19,
                            ),
                          ),
                          YMargin(10),
                          Divider(),
                          YMargin(10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 6.0,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? ProbitasColor.ProbitasTextSecondary
                                        : ProbitasColor.ProbitasSecondary,
                                    borderRadius: BorderRadius.circular(12.0)),
                              ),
                              XMargin(15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  YMargin(5.0),
                                  Container(
                                    width: context.screenWidth() / 1.5,
                                    child: Text(
                                      "Full Name: ${data.data!.user!.sponsor!.fullName}",
                                      style: Config.b2(context),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  YMargin(5.0),
                                  Container(
                                    width: context.screenWidth() - 70,
                                    child: Text(
                                      "Address: ${data.data!.user!.sponsor!.address}",
                                      style: Config.b2(context),
                                    ),
                                  ),
                                  YMargin(5),
                                  Container(
                                    width: context.screenWidth() / 1.4,
                                    child: Text(
                                      "Phone Number: ${data.data!.user!.sponsor!.phoneNumber}",
                                      style: Config.b2(context),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  YMargin(5),
                                  Container(
                                    width: context.screenWidth() / 1.5,
                                    child: Text(
                                      "Email: ${data.data!.user!.sponsor!.email}",
                                      style: Config.b2(context),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          YMargin(10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          error: (err, str) =>
              ErrorsWidget(onTap: () => ref.refresh(getUserProvider)),
          loading: () => Center(
                  child: CircularProgressIndicator(
                color: ProbitasColor.ProbitasSecondary,
              ))),
    );
  }
}
