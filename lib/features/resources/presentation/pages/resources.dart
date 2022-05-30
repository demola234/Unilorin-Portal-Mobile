import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/components.dart';
import 'package:probitas_app/core/utils/navigation_service.dart';
import 'package:probitas_app/features/dashboard/presentation/widget/empty_state/empty_state.dart';
import 'package:probitas_app/features/resources/data/model/resource_response.dart';
import 'package:probitas_app/features/resources/presentation/pages/download_screen.dart';
import 'package:probitas_app/features/resources/presentation/pages/pdf_viewer.dart';
// ignore: unused_import
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_appbar.dart';
import '../../../../core/utils/customs/custom_drawers.dart';
import '../controller/resource_controller.dart';
import 'add_resources.dart';

class Resources extends ConsumerStatefulWidget {
  const Resources({Key? key}) : super(key: key);

  @override
  ConsumerState<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends ConsumerState<Resources> {
  TextEditingController searchController = TextEditingController();

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                color: isDarkMode
                    ? ProbitasColor.ProbitasTextPrimary
                    : ProbitasColor.ProbitasPrimary,
                fontSize: 18,
              ),
            ),
          ]),
          YMargin(10),
          Row(
            children: [
              Flexible(
                child: ProbitasTextFormField(
                  controller: searchController,
                  onChanged: (v) {
                    setState(() {
                      v = searchController.text;
                    });
                  },
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search for Pdf, Past Questions, etc...",
                ),
              ),
            ],
          ),
          YMargin(15),
          searchController.text.isEmpty
              ? Expanded(
                  child: Container(
                      height: context.screenHeight(),
                      width: context.screenWidth(),
                      child: ref.watch(getResourcesNotifier).when(
                          data: (data) => ListView.builder(
                              itemCount: data.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final response = data.data![index];
                                return ResourceTile(response: response);
                              }),
                          error: (err, _) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Center(
                                          child: EmptyState(
                                        text: "An Error Occurred",
                                      ))),
                                ],
                              ),
                          loading: () => Center(
                                child: CircularProgressIndicator(
                                    color: ProbitasColor.ProbitasSecondary),
                              ))))
              : Expanded(
                  child: Container(
                      height: context.screenHeight(),
                      width: context.screenWidth(),
                      child: ref
                          .watch(getResourcesSearchedNotifier(
                              searchController.text))
                          .when(
                              data: (data) => ListView.builder(
                                  itemCount: data.data!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final response = data.data![index];
                                    return ResourceTile(response: response);
                                  }),
                              error: (err, _) => SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Center(
                                                child: EmptyState(
                                              text: "No Resource Found",
                                            ))),
                                      ],
                                    ),
                                  ),
                              loading: () => Center(
                                    child: CircularProgressIndicator(
                                        color: ProbitasColor.ProbitasSecondary),
                                  )))),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService().navigateToScreen(AddResources());
        },
        backgroundColor: ProbitasColor.ProbitasSecondary,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ResourceTile extends StatefulWidget {
  Datum? response;

  ResourceTile({
    required this.response,
    Key? key,
  }) : super(key: key);

  @override
  State<ResourceTile> createState() => _ResourceTileState();
}

class _ResourceTileState extends State<ResourceTile> {
  bool isLoading = false;
  late Dio dio;
  late String progress;
  // ignore: unused_field
  String? _fileFullPath;

  @override
  void initState() {
    dio = Dio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<Null>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                  // borderRadius: _borderRadius,
                  ),
              height: context.screenHeight() / 3,
              child: Column(
                children: [
                  YMargin(10),
                  Container(
                      height: 6,
                      width: context.screenWidth() / 3.5,
                      decoration: BoxDecoration(
                          color: ProbitasColor.ProbitasTextPrimary.withOpacity(
                              0.7),
                          borderRadius: BorderRadius.circular(5.0))),
                  YMargin(30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 70.0,
                          height: 100,
                          decoration: BoxDecoration(
                              color: ProbitasColor.ProbitasTextSecondary,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.response!.courseCode!,
                                style: Config.b2(context).copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.response!.file!
                                    .split(".")
                                    .last
                                    .toUpperCase(),
                                style: Config.b2(context).copyWith(
                                  color: ProbitasColor.ProbitasTextPrimary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        XMargin(15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            YMargin(2.0),
                            Text(
                              widget.response!.courseTitle!,
                              style: Config.b2(context).copyWith(
                                // color: ProbitasColor.ProbitasPrimary,
                                fontSize: 12,
                              ),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    "By ${widget.response!.user!.fullName!.split(" ")[0]} ${widget.response!.user!.fullName!.split(" ")[1]}",
                                    style: Config.b2(context).copyWith(
                                      // color: ProbitasColor.ProbitasPrimary,
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: false,
                                isDismissible: false,
                                context: context,
                                builder: (context) => DownloadScreen(
                                      url: widget.response!.file!,
                                    ));
                          },
                          icon: SvgPicture.asset(ImagesAsset.download,
                              color: isDarkMode
                                  ? ProbitasColor.ProbitasTextSecondary
                                  : ProbitasColor.ProbitasPrimary),
                        )
                      ],
                    ),
                  ),
                  YMargin(30),
                  widget.response!.file!.split(".").last.toLowerCase() == "pdf"
                      ? ProbitasButton(
                          onTap: () {
                            NavigationService().navigateToScreen(PDFViewer(
                              path: widget.response!.file!,
                            ));
                          },
                          text: "View Material")
                      : SizedBox.shrink()
                ],
              ),
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        height: 120,
        width: context.screenWidth(),
        decoration: BoxDecoration(
          color: ProbitasColor.ProbitasTextSecondary,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70.0,
                height: 100,
                decoration: BoxDecoration(
                    color: ProbitasColor.ProbitasTextPrimary,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.response!.courseCode!,
                      style: Config.b2(context).copyWith(
                          color: ProbitasColor.ProbitasSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.response!.file!.split(".").last.toUpperCase(),
                      style: Config.b2(context).copyWith(
                        color: ProbitasColor.ProbitasSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              XMargin(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  YMargin(2.0),
                  Text(
                    widget.response!.courseTitle!,
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
                      Text(
                          "By ${widget.response!.user!.fullName!.split(" ")[0]} ${widget.response!.user!.fullName!.split(" ")[1]}",
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

  Future<List<Directory>?> _getExternalStoragePath() {
    return path.getExternalStorageDirectories(
        type: path.StorageDirectory.documents);
  }

  Future _downloadSaveFileToStorage(String urlPath, String fileName) async {
    try {
      final dirList = await _getExternalStoragePath();
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
