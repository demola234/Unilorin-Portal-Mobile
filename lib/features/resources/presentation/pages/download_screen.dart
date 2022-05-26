import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/utils/config.dart';

class DownloadScreen extends StatefulWidget {
  final String url;

  DownloadScreen({required this.url});
  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  Dio dio = Dio();
  String downloadProgress = '0';
  int downloadedBytes = 0;
  int totalBytes = 0;

  static formatBytes(bytes, decimals) {
    if (bytes == 0) return 0.0;
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }

  void downloadBook(String link) async {
    PermissionStatus permissionStatus = await Permission.storage.request();

    if (permissionStatus.isGranted) {
      Directory? appDirectory = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationSupportDirectory();
      if (Platform.isAndroid) {
        Directory(appDirectory!.path.split('Android')[0] + 'Probitas')
            .createSync();
      }

      String path = Platform.isIOS
          ? appDirectory!.path + '/${widget.url.toString().split(".").last}'
          : appDirectory!.path.split('Android')[0] +
              'Probitas/${widget.url.toString().split(".").last}';
      print('path is $path');
      File file = File(path);
      if (!await file.exists()) {
        await file.create();
      } else {
        await file.delete();
        await file.create();
      }
      await dio.download(
        link,
        path,
        options: Options(
          followRedirects: true,
          headers: {HttpHeaders.acceptEncodingHeader: "*"},
        ),
        deleteOnError: true,
        onReceiveProgress: (received, total) async {
          if (total != -1) {
            setState(() {
              downloadedBytes = received;
              totalBytes = total;
              downloadProgress = (received / total * 100).toStringAsFixed(0);
            });
          } else {
            Navigator.pop(context, false);
          }
        },
      );
    } else {
      permissionStatus = await Permission.storage.request();
    }
  }

  @override
  void initState() {
    super.initState();
    downloadBook(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: LiquidLinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation(ProbitasColor.ProbitasSecondary),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        value: double.parse(downloadProgress) / 100.0,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Downloading...',
                style: Config.b2(context).copyWith(
                  color: Colors.white,
                )),
            YMargin(5),
            Text('$downloadProgress %',
                style: Config.h3(context).copyWith(
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
