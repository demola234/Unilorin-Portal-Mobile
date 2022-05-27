import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';

class ImageViewUtils {
  static showImagePreview(BuildContext context, List<String> urls,
      {int index = 0}) {
    MultiImageProvider multiImageProvider = MultiImageProvider(
        urls.map((e) => CachedNetworkImageProvider(e)).toList(),
        initialIndex: index);

    showImageViewerPager(context, multiImageProvider, onPageChanged: (page) {
      print("page changed to $page");
    }, onViewerDismissed: (page) {
      print("dismissed while on page $page");
    });
  }
}
