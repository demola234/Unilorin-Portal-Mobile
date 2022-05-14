import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'package:probitas_app/features/dashboard/presentation/controller/dashboard_controller.dart';
import '../../core/constants/colors.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';
import '../../core/utils/shimmer_loading.dart';

class Profile extends ConsumerWidget {
  Profile({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(getUsersProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Profile"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 100,
            width: context.screenWidth(),
            decoration: BoxDecoration(
                color: ProbitasColor.ProbitasTextPrimary.withOpacity(0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )),
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
                          child: value.when(
                              data: (data) => ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fitWidth,
                                      imageUrl: data.data!.user!.avatar!,
                                    ),
                                  ),
                              error: (err, str) => Text("error"),
                              loading: () => Loading(
                                    height: 60,
                                    width: 60,
                                  ))),
                      XMargin(20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.when(
                                data: (data) => data.data!.user!.fullName!,
                                error: (err, str) => "error",
                                loading: () => "loading"),
                            maxLines: 1,
                            style: Config.b2(context).copyWith(
                                color: isDarkMode
                                    ? Colors.white
                                    : ProbitasColor.ProbitasPrimary),
                          ),
                          YMargin(2.0),
                          Text(
                            value.when(
                                data: (data) =>
                                    "${data.data!.user!.level!} Level",
                                error: (err, str) => "error",
                                loading: () => "loading"),
                            style: Config.b2(context).copyWith(
                                color: isDarkMode
                                    ? ProbitasColor.ProbitasTextPrimary
                                    : ProbitasColor.ProbitasTextSecondary),
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
                            // "Full Name:  Femi Ademola",
                            value.when(
                                data: (data) =>
                                    "Full Name: ${data.data!.user!.fullName!}",
                                error: (err, str) => "error",
                                loading: () => "loading"),
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            // "Sex: Male",
                            value.when(
                                data: (data) =>
                                    "Sex: ${data.data!.user!.gender!}",
                                error: (err, str) => "error",
                                loading: () => "loading"),
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            // "Current Session: 2020/2021",
                            value.when(
                                data: (data) =>
                                    "Current Session: ${data.data!.user!.session!}",
                                error: (err, str) => "error",
                                loading: () => "loading"),
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            // "Phone Number: 08028929292",
                            value.when(
                                data: (data) =>
                                    "Phone Number: ${data.data!.user!.phoneNumber!}",
                                error: (err, str) => "error",
                                loading: () => "loading"),
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            // "Faculty: Physical Science",
                            value.when(
                                data: (data) =>
                                    "Faculty: ${data.data!.user!.faculty!}",
                                error: (err, str) => "error",
                                loading: () => "loading"),
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            // "Department: Industrial Chemistry",
                            value.when(
                                data: (data) =>
                                    "Department: ${data.data!.user!.department!}",
                                error: (err, str) => "error",
                                loading: () => "loading"),
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            // "Programme: B.sc ICS",
                            value.when(
                                data: (data) =>
                                    "Programme: ${data.data!.user!.course!}",
                                error: (err, str) => "error",
                                loading: () => "loading"),
                            style: Config.b2(context),
                            overflow: TextOverflow.ellipsis,
                          ),
                          YMargin(5),
                          Text(
                            // "Studentship Status: Returning",
                            value.when(
                                data: (data) =>
                                    "Studentship Status: ${data.data!.user!.studentShipStatus!}",
                                error: (err, str) => "error",
                                loading: () => "loading"),
                            style: Config.b2(context),
                            overflow: TextOverflow.ellipsis,
                          ),
                          YMargin(5),
                          Text(
                            value.when(
                                data: (data) =>
                                    "Charges Paid: ${data.data!.user!.chargesPaid!}",
                                error: (err, str) => "error",
                                loading: () => "loading"),
                            style: Config.b2(context),
                            overflow: TextOverflow.ellipsis,
                          ),
                          YMargin(5),
                          Text(
                            // "Mode of Entry: UTME",
                            value.when(
                                data: (data) =>
                                    "Studentship Status: ${data.data!.user!.modeOfEntry!}",
                                error: (err, str) => "error",
                                loading: () => "loading"),
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Container(
                            width: context.screenWidth() / 1.7,
                            child: Text(
                              // "Student Email: 12/EQ33123@students.....",
                              value.when(
                                  data: (data) =>
                                      "Studentship Email: ${data.data!.user!.studentEmail!}",
                                  error: (err, str) => "error",
                                  loading: () => "loading"),
                              style: Config.b2(context),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          YMargin(5),
                          Container(
                            width: context.screenWidth() / 1.7,
                            child: Text(
                              // "Permanent/Home Address:",
                              value.when(
                                  data: (data) =>
                                      "Permanent/Home Address:: ${data.data!.user!.address!}",
                                  error: (err, str) => "error",
                                  loading: () => "loading"),
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
                    "Your Level Adviser Details",
                    style: Config.h3(context).copyWith(
                      fontSize: 19,
                    ),
                  ),
                  YMargin(10),
                  Divider(),
                  YMargin(10),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                              // "Full Name: Idowu Alisa",
                              value.when(
                                  data: (data) =>
                                      "Full Name: ${data.data!.user!.levelAdviser!.fullName}",
                                  error: (err, str) => "error",
                                  loading: () => "loading"),
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
                              // "Full Name: Idowu Alisa",
                              value.when(
                                  data: (data) =>
                                      "Phone Number: ${data.data!.user!.levelAdviser!.phoneNumber}",
                                  error: (err, str) => "error",
                                  loading: () => "loading"),
                              style: Config.b2(context),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          YMargin(5),

                          Container(
                            width: context.screenWidth() / 1.5,
                            child: Text(
                              value.when(
                                  data: (data) =>
                                      "Email: ${data.data!.user!.levelAdviser!.email}",
                                  error: (err, str) => "error",
                                  loading: () => "loading"),
                              style: Config.b2(context),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ])
                  ])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
