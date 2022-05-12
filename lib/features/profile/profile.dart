import 'package:flutter/material.dart';
import 'package:probitas_app/core/utils/config.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/image_path.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        child: Image(
                          image: AssetImage(ImagesAsset.default_image),
                        ),
                      ),
                      XMargin(20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Femi Ademola",
                            maxLines: 1,
                            style: Config.b2(context)
                                .copyWith(color: ProbitasColor.ProbitasPrimary),
                          ),
                          YMargin(2.0),
                          Text(
                            "200 Level",
                            style: Config.b2(context).copyWith(
                                color: ProbitasColor.ProbitasTextSecondary),
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
          Expanded(
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
                            color: ProbitasColor.ProbitasSecondary,
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      XMargin(15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          YMargin(5.0),
                          Text(
                            "Full Name:  Femi Ademola",
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            "Sex: Male",
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            "Current Session: 2020/2021",
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            "Phone Number: 08028929292",
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            "Faculty: Physical Science",
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            "Department: Induestral Chemistry",
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            "Programme: B.sc ICS",
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            "Studentship Status: Returning",
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            "Charges Paid: Yes",
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            "Mode of Entry: UTME",
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            "Student Email: 12/EQ33123@students.....",
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            "Permanent/Home Address:",
                            style: Config.b2(context),
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
                          color: ProbitasColor.ProbitasSecondary,
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    XMargin(15),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          YMargin(5.0),
                          Text(
                            "Full Name: Idowu Adisa",
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            "Phone Number: 0712929292",
                            style: Config.b2(context),
                          ),
                          YMargin(5),
                          Text(
                            "Email:Adisa@gmail.com",
                            style: Config.b2(context),
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
