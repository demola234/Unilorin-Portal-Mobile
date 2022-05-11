import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/components.dart';
import 'package:probitas_app/core/utils/navigation_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_appbar.dart';
import '../../../../core/utils/customs/custom_drawers.dart';
import 'add_resources.dart';

class Resources extends StatefulWidget {
  const Resources({Key? key}) : super(key: key);

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomAppbar(
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
      ),
      drawer: ProbitasDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: [
          YMargin(10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Resources",
              style: Config.h3(context).copyWith(
                color: ProbitasColor.ProbitasPrimary,
                fontSize: 18,
              ),
            ),
          ]),
          YMargin(10),
          Row(
            children: [
              Flexible(
                child: ProbitasTextFormField(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search for Pdf, Past Questions, etc...",
                ),
              ),
              XMargin(5.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ProbitasColor.ProbitasSecondry,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(ImagesAsset.filter),
                  ),
                ),
              ),
            ],
          ),
          YMargin(15),
          Expanded(
              child: Container(
                  height: context.screenHeight(),
                  width: context.screenWidth(),
                  child: ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ResourceTile();
                      })))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService().navigateToScreen(AddResources());
        },
        backgroundColor: ProbitasColor.ProbitasSecondry,
        child: Icon(Icons.add),
      ),
    );
  }
}

class ResourceTile extends StatefulWidget {
  ResourceTile({
    Key? key,
  }) : super(key: key);

  @override
  State<ResourceTile> createState() => _ResourceTileState();
}

class _ResourceTileState extends State<ResourceTile> {
  bool isLoading = false;
  late Dio dio;
  late String progress;
  late String _fileFullPath;
  String url =
      "http://docs.google.com/viewer?url=http://www.pdf995.com/samples/pdf.pdf";
  @override
  void initState() {
    dio = Dio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _downloadndSaveFileToStorage(url, "document.pdf");
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        height: 120,
        width: context.screenWidth(),
        decoration: BoxDecoration(
            color: ProbitasColor.ProbitasTextSecondary,
            borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 6.0,
                height: 100,
                decoration: BoxDecoration(
                    color: ProbitasColor.ProbitasTextPrimary,
                    borderRadius: BorderRadius.circular(12.0)),
              ),
              XMargin(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YMargin(20.0),
                  Text(
                    "LIS121",
                    style: Config.b2(context).copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  YMargin(2.0),
                  Text(
                    "Library and Information Techiniques",
                    style: Config.b2(context).copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("By Stephen Peter",
                          style: Config.b2(context).copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          )),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Directory>?> _getExternalStroagePath() {
    return path.getExternalStorageDirectories(
        type: path.StorageDirectory.documents);
  }

  Future _downloadndSaveFileToStorage(String urlPath, String fileName) async {
    try {
      final dirList = await _getExternalStroagePath();
      final path = dirList![0].path;
      final file = File("$path/$fileName");
      await dio.download(urlPath, file.path, onReceiveProgress: (rec, total) {
        setState(() {
          isLoading = true;
          progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
          print(progress);
        });
      });
      _fileFullPath = file.path;
    } catch (e) {
      print(e);
    }
  }

  // Future openFile({required String url, String? fileName}) async {
  //   final name = fileName ?? url.split('/').last;

  //   final file = await downloadFile(url, name);
  //   print(file);
  //   if (file == null) return;

  //   print("${file.path}");

  //   OpenFile.open(file.path);
  // }

  // Future<File?> downloadFile(String url, String name) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final file = File('${appStorage.path}/$name');
  //   try {
  //     final response = await Dio().get(url,
  //         options: Options(
  //           responseType: ResponseType.bytes,
  //           followRedirects: false,
  //           receiveTimeout: 0,
  //         ));
  //     print(response);
  //     final raf = file.openSync(mode: FileMode.write);
  //     raf.writeByteSync(response.data);
  //     await raf.close();

  //     return file;
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
