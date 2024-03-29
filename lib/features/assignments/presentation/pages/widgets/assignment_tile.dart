import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/config.dart';

class AssignmentTile extends StatelessWidget {
  final String courseCode;
  final String courseTitle;
  final DateTime dueDate;
  final String lecturer;
  final String assignmentId;
  final Function()? onTap;
  AssignmentTile({
    required this.courseCode,
    required this.courseTitle,
    required this.dueDate,
    required this.lecturer,
    required this.assignmentId,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        height: 140,
        width: context.screenWidth(),
        decoration: BoxDecoration(
            border: Border.all(
                color: isDarkMode
                    ? ProbitasColor.ProbitasTextPrimary.withOpacity(0.5)
                    : ProbitasColor.ProbitasSecondary.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                // decoration: BoxDecoration(
                //     color: ProbitasColor.ProbitasTextPrimary,
                //     borderRadius: BorderRadius.circular(12.0)),
                child: SvgPicture.asset(ImagesAsset.books),
              ),
              XMargin(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YMargin(20.0),
                  Text(
                    courseCode.toUpperCase(),
                    style: Config.b2(context).copyWith(
                      fontSize: 12,
                    ),
                  ),
                  YMargin(2.0),
                  Text(
                    courseTitle,
                    style: Config.b2(context).copyWith(
                      fontSize: 12,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: ProbitasColor.ProbitasSecondary,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          "Due: ${DateFormat.MMMMEEEEd().addPattern(",").add_jm().format(dueDate)}",
                          style: Config.b2(context).copyWith(
                            fontSize: 12,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("By $lecturer",
                          style: Config.b2(context).copyWith(
                            fontSize: 12,
                          )),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
