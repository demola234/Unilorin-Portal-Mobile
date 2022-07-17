import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/config.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';
import '../../../dashboard/presentation/widget/empty_state/empty_state.dart';
import '../../../resources/presentation/pages/download_screen.dart';
import '../controller/assignment_controller.dart';

class SubmittedAssignmentByUser extends StatefulHookConsumerWidget {
  String courseName;
  String assignmentId;
  String courseCode;
  SubmittedAssignmentByUser({
    required this.courseName,
    required this.assignmentId,
    required this.courseCode,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SubmittedAssignmentByUser> createState() =>
      _SubmittedAssignmentState();
}

class _SubmittedAssignmentState
    extends ConsumerState<SubmittedAssignmentByUser> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final assignmentState = ref.watch(getSubmittedAssignmentProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "${widget.courseName} Assignment"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(children: [
            YMargin(10),
            Expanded(
              child: Container(
                width: context.screenWidth(),
                child: assignmentState.when(
                  data: (data) => ListView.builder(
                      itemCount: data.data.assignments.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return (data.data.assignments[index].courseTitle ==
                                    widget.courseName &&
                                data.data.assignments[index].courseCode ==
                                    widget.courseCode)
                            ? GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  height: 140,
                                  width: context.screenWidth(),
                                  decoration: BoxDecoration(
                                      // color:
                                      //     ProbitasColor.ProbitasTextSecondary,
                                      border: Border.all(
                                        color: isDarkMode
                                            ? ProbitasColor.ProbitasTextPrimary
                                                .withOpacity(0.5)
                                            : ProbitasColor.ProbitasSecondary
                                                .withOpacity(0.5),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          // decoration: BoxDecoration(
                                          //     color: ProbitasColor.ProbitasTextPrimary,
                                          //     borderRadius: BorderRadius.circular(12.0)),
                                          child: SvgPicture.asset(
                                              ImagesAsset.books),
                                        ),
                                        XMargin(15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            YMargin(20.0),
                                            Text(
                                              data.data.assignments[index]
                                                  .courseTitle,
                                              style:
                                                  Config.b2(context).copyWith(
                                                fontSize: 12,
                                              ),
                                            ),
                                            // Divider(),
                                            YMargin(2.0),
                                            Text(
                                              "Student: ${data.data.assignments[index].user.fullName.split(" ")[0]} ${data.data.assignments[index].user.fullName.split(" ")[1]}",
                                              style:
                                                  Config.b2(context).copyWith(
                                                fontSize: 12,
                                              ),
                                            ),
                                            // Divider(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                    "Matric Number ${data.data.assignments[index].user.department}",
                                                    style: Config.b2(context)
                                                        .copyWith(
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                isScrollControlled: false,
                                                isDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return DownloadScreen(
                                                    url: data
                                                        .data
                                                        .assignments[index]
                                                        .user
                                                        .avatar,
                                                    title: data
                                                        .data
                                                        .assignments[index]
                                                        .department,
                                                  );
                                                });
                                          },
                                          icon: SvgPicture.asset(
                                              ImagesAsset.download,
                                              color: isDarkMode
                                                  ? ProbitasColor
                                                      .ProbitasTextSecondary
                                                  : ProbitasColor
                                                      .ProbitasSecondary),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.fromSize();
                      }),
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color: ProbitasColor.ProbitasSecondary,
                    ),
                  ),
                  error: (err, str) => Text(err.toString()),
                ),
              ),
            )
          ])),
    );
  }
}
