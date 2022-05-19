import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EmptyState extends StatelessWidget {
  EmptyState({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Lottie.asset(
            ImagesAsset.empty,
            height: 200,
            width: 200,
            animate: true,
            repeat: true,
          ),
          Text(
            "No Schedule Available",
            style: Config.b2(context),
          )
        ],
      ),
    );
  }
}
