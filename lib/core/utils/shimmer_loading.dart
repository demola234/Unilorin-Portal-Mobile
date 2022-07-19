import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';

class Loading extends StatelessWidget {
  final double width;
  final double height;

  Loading({
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ProbitasColor.ProbitasSecondary.withOpacity(0.2),
        highlightColor: ProbitasColor.ProbitasTextPrimary.withOpacity(0.4),
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            )));
  }
}
