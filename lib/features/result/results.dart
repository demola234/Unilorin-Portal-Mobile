import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/image_path.dart';
import '../../core/utils/config.dart';
import '../posts/presentation/pages/post_overview.dart';

class Result extends StatefulWidget {
  Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Result"),
      ),
      body: Column(children: [
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
                          "First Semester",
                          style: Config.b2(context).copyWith(
                              color: ProbitasColor.ProbitasTextSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "CGPA",
                    style: Config.b2(context)
                        .copyWith(color: ProbitasColor.ProbitasPrimary),
                  ),
                  YMargin(2.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(ImagesAsset.calculator),
                        XMargin(2),
                        Text(
                          isVisible ? "4.34" : "---",
                          style: Config.b2(context).copyWith(
                              color: ProbitasColor.ProbitasTextSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
