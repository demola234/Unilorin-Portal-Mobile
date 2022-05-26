import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:probitas_app/features/dashboard/presentation/widget/empty_state/empty_state.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';

class PDFViewer extends StatefulWidget {
  PDFViewer({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "PDF Viewer"),
      ),
      body: PDF().cachedFromUrl(
        widget.path,
        maxAgeCacheObject: Duration(days: 10),
        maxNrOfCacheObjects: 5,
        placeholder: (double progress) => Center(
            child: Container(
          height: 150,
          width: context.screenWidth() / 3,
          child: LiquidCircularProgressIndicator(
            value: progress / 100,
            valueColor: AlwaysStoppedAnimation(isDarkMode
                ? ProbitasColor.ProbitasTextSecondary
                : ProbitasColor.ProbitasSecondary),
            backgroundColor: Colors.white,
            center: Text('$progress %',
                style: Config.b3(context).copyWith(
                  color: ProbitasColor.ProbitasTextPrimary,
                )),
          ),
        )),
        errorWidget: (dynamic error) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: EmptyState(text: error.toString())),
            ),
          ],
        ),
      ),
    );
  }
}
