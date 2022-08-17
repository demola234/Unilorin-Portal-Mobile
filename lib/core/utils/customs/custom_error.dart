
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/colors.dart';
import '../../constants/image_path.dart';
import '../config.dart';

class ErrorsWidget extends StatelessWidget {
  final Function()? onTap;
  ErrorsWidget({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Center(
        child: Container(
            child: Column(
      children: [
        Lottie.asset(
          ImagesAsset.empty_screens,
          height: 200,
          width: 200,
          animate: true,
          repeat: true,
        ),
        Text(
          "An Error Occurred",
          style: Config.b2(context).copyWith(
            color: isDarkMode ? ProbitasColor.ProbitasTextPrimary 
                : ProbitasColor.ProbitasPrimary
          ),
        ),
        YMargin(10),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 35,
            width: 130,
            decoration: BoxDecoration(
                border: Border.all(color: isDarkMode ? ProbitasColor.ProbitasTextPrimary 
                : ProbitasColor.ProbitasPrimary),

                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: Center(
                child: Text("Tap to Retry",
                    style: Config.b3(context).copyWith(
                      color: isDarkMode ? ProbitasColor.ProbitasTextPrimary 
                : ProbitasColor.ProbitasPrimary
                    ))),
          ),
        ),
      ],
    )));
  }
}
