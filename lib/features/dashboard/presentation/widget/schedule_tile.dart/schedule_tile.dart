import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:probitas_app/core/utils/config.dart';

import '../../../../../core/constants/colors.dart';
import '../../../data/model/schedules_response.dart';

class ScheduleTile extends StatelessWidget {
  var timeFormat = DateFormat.jm();
  String courseCode;
  String courseTitle;
  String venue;
  DateTime startTime;
  DateTime endTime;
  ScheduleTile({
    required this.courseCode,
    required this.courseTitle,
    required this.venue,
    required this.startTime,
    required this.endTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<Null>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                  // borderRadius: _borderRadius,
                  ),
              height: context.screenHeight() / 2,
              child: Container(),
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
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
                      Text(venue,
                          textAlign: TextAlign.right,
                          style: Config.b2(context).copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Time",
                        style: Config.b2(context).copyWith(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text("Venue",
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
