import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:probitas_app/core/utils/config.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_path.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';

class SubmittedAssignment extends StatelessWidget {
  const SubmittedAssignment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Submitted Assignment"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
                    width: context.screenWidth(),
                    child: ListView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            height: 140,
                            width: context.screenWidth(),
                            decoration: BoxDecoration(
                                color: ProbitasColor.ProbitasTextSecondary,
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 6.0,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color:
                                            ProbitasColor.ProbitasTextPrimary,
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                  ),
                                  XMargin(15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        "Library and Information Techniques",
                                        style: Config.b2(context).copyWith(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text("Submitted By: Stephen Pete",
                                              style:
                                                  Config.b2(context).copyWith(
                                                color: Colors.white,
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text("Matric Number: 19/33TH123",
                                              style:
                                                  Config.b2(context).copyWith(
                                                color: Colors.white,
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      Container();
                                    },
                                    icon: SvgPicture.asset(ImagesAsset.download,
                                        color: isDarkMode
                                            ? ProbitasColor
                                                .ProbitasTextSecondary
                                            : ProbitasColor.ProbitasPrimary),
                                  )
                                ],
                              ),
                            ),
                          );
                        }))),
          ],
        ),
      ),
    );
  }
}
