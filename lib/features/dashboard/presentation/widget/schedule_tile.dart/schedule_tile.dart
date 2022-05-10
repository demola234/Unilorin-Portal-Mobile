import 'package:flutter/material.dart';
import 'package:probitas_app/core/utils/config.dart';

import '../../../../../core/constants/colors.dart';

class ScheduleTile extends StatelessWidget {
  const ScheduleTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  "LIS121",
                  style: Config.b2(context).copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                YMargin(2.0),
                Text(
                  "Library and Information Techiniques",
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
                      "8:00 AM - 9:00AM",
                      style: Config.b2(context).copyWith(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    XMargin(context.screenWidth() - 240),
                    Text("SLT",
                        style: Config.b2(context).copyWith(
                          color: Colors.white,
                          fontSize: 12,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Time",
                      style: Config.b2(context).copyWith(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    XMargin(context.screenWidth() - 175),
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
    );
  }
}
