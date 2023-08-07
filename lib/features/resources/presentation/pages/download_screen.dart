// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'package:saf/saf.dart';

import '../../../../core/error/toasts.dart';

class DownloadScreen extends StatefulWidget {
  final String url;
  final String title;

  DownloadScreen({required this.url, required this.title});
  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

const directory = "Probitas";

class _DownloadScreenState extends State<DownloadScreen> {
  Dio dio = Dio();
  String downloadProgress = '0';
  int downloadedBytes = 0;
  int totalBytes = 0;
  late Saf saf;

  static formatBytes(bytes, decimals) {
    if (bytes == 0) return 0.0;
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status != PermissionStatus.granted) {
      Toasts.showErrorToast('Permission not granted');
      return false;
    }
    return true;
  }

  Future<bool> _hasAcceptedPermissions() async {
    if (Platform.isAndroid) {
      if (await _requestPermission(Permission.storage)) {
        return true;
      } else {
        return false;
      }
    }
    if (Platform.isIOS) {
      if (await _requestPermission(Permission.storage) ||
          await _requestPermission(Permission.mediaLibrary)) {
        return true;
      } else {
        return false;
      }
    } else {
      // not android or ios
      return false;
    }
  }

  void downloadBook(String link) async {
    if (await _hasAcceptedPermissions()) {
      String timeInMilliseconds =
          DateTime.now().millisecondsSinceEpoch.toString();
      String fileName =
          "/$timeInMilliseconds.${widget.url.toString().split(".").last}";

      String path = '';

      if (Platform.isAndroid) {
        // await saf.releasePersistedPermission();
        // await Saf.getPersistedPermissionDirectories();

        bool? isGrantedDirectoryPermission =
            await saf.getDirectoryPermission(isDynamic: true);

        if (isGrantedDirectoryPermission != null &&
            isGrantedDirectoryPermission) {
          List<String>? directoriesPath =
              await Saf.getPersistedPermissionDirectories();
          print('directories path is $directoriesPath');
          path = '/storage/emulated/0/' + directoriesPath![0] + fileName;
        } else {
          Toasts.showErrorToast('Storage location not selected');
          return;
        }
      } else {
        Directory? appDirectory = await getApplicationDocumentsDirectory();
        path = appDirectory.path + fileName;
      }

      File file = File(path);
      if (!await file.exists()) {
        await file.create();
      } else {
        await file.delete();
        await file.create();
      }

      await dio
          .download(
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
                  downloadProgress =
                      (received / total * 100).toStringAsFixed(0);
                });
              } else {
                Navigator.pop(context, false);
              }
            },
          )
          .catchError(
            // ignore: invalid_return_type_for_catch_error
            (e) => {
              Toasts.showErrorToast("An Error Occurred!"),
              Navigator.pop(context, true),
            },
          )
          .then((value) async {
            var downloadSize = formatBytes(totalBytes, 1);
            Toasts.showSuccessToast("Download Successful");
            Navigator.pop(context);
          });
    }
  }

  @override
  void initState() {
    saf = Saf(directory);
    downloadBook(widget.url);
    super.initState();
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
                  color: ProbitasColor.ProbitasTextPrimary,
                )),
            YMargin(5),
            Text('$downloadProgress %',
                style: Config.h3(context).copyWith(
                  color: ProbitasColor.ProbitasTextPrimary,
                )),
          ],
        ),
      ),
    );
  }
}
