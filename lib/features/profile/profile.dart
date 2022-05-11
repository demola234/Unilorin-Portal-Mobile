import 'package:flutter/material.dart';
import 'package:probitas_app/core/utils/config.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/image_path.dart';
import '../posts/presentation/pages/post_overview.dart';

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
          
        ],
      ),
    );
  }
}
