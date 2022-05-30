import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'package:readmore/readmore.dart';

import '../../../../../core/constants/colors.dart';
import '../../../data/model/schedules_response.dart';
import '../../controller/dashboard_controller.dart';

class ScheduleTile extends ConsumerWidget {
  var timeFormat = DateFormat.jm();
  String courseCode;
  String courseId;
  String courseTitle;
  String courseNote;
  String venue;
  DateTime startTime;
  DateTime endTime;
  ScheduleTile({
    required this.courseCode,
    required this.courseId,
    required this.courseTitle,
    required this.courseNote,
    required this.venue,
    required this.startTime,
    required this.endTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<Null>(
          context: context,
          builder: (BuildContext context) {
            return Container(
                decoration: BoxDecoration(
                    // borderRadius: _borderRadius,
                    ),
                height: context.screenHeight() / 2.8,
                child: Column(children: [
                  YMargin(10),
                  Container(
                      height: 6,
                      width: context.screenWidth() / 3.5,
                      decoration: BoxDecoration(
                          color: ProbitasColor.ProbitasTextPrimary.withOpacity(
                              0.7),
                          borderRadius: BorderRadius.circular(5.0))),
                  YMargin(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        YMargin(20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              courseCode,
                            ),
                            IconButton(
                              onPressed: () {
                                ref.watch(deleteSchedulesProvider(courseId));
                                Future.delayed(const Duration(seconds: 1), () {
                                  ref.refresh(getSchedulesProvider);
                                });

                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.delete),
                            )
                          ],
                        ),
                        YMargin(5.0),
                        Text(
                          courseTitle,
                        ),
                        YMargin(5.0),
                        Divider(),
                        Container(
                          height: 80,
                          child: ListView(
                            children: [
                              ReadMoreText(
                                "Note: $courseNote",
                                style:
                                    Config.b3(context).copyWith(fontSize: 14.0),
                                textAlign: TextAlign.left,
                                trimLines: 3,
                                delimiter: "...",
                                colorClickableText: isDarkMode
                                    ? ProbitasColor.ProbitasTextPrimary
                                    : ProbitasColor.ProbitasPrimary,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Read More',
                                trimExpandedText: 'Close',
                                lessStyle: Config.b2(context).copyWith(
                                    color: isDarkMode
                                        ? ProbitasColor.ProbitasTextPrimary
                                        : ProbitasColor.ProbitasSecondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                                moreStyle: Config.b2(context).copyWith(
                                  color: isDarkMode
                                      ? ProbitasColor.ProbitasTextPrimary
                                      : ProbitasColor.ProbitasSecondary,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        YMargin(5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${timeFormat.format(startTime)} - ${timeFormat.format(endTime)}",
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        YMargin(5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              venue,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ]));
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        height: 140,
        width: context.screenWidth(),
        decoration: BoxDecoration(
            color: ProbitasColor.ProbitasTextSecondary,
            borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 6.0,
                height: 100,
                decoration: BoxDecoration(
                    color: ProbitasColor.ProbitasTextPrimary,
                    borderRadius: BorderRadius.circular(12.0)),
              ),
              XMargin(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YMargin(20.0),
                  Text(
                    courseCode,
                    style: Config.b2(context).copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  YMargin(2.0),
                  Text(
                    courseTitle,
                    style: Config.b2(context).copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${timeFormat.format(startTime)} - ${timeFormat.format(endTime)}",
                        textAlign: TextAlign.left,
                        style: Config.b2(context).copyWith(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(venue,
                          textAlign: TextAlign.right,
                          style: Config.b2(context).copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          )),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
