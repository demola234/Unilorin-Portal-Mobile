import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/error/toasts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/allowed_extension.dart';
import '../../../../core/utils/components.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';
import '../../../posts/presentation/pages/posts.dart';

class AddResources extends StatefulWidget {
  const AddResources({Key? key}) : super(key: key);

  @override
  State<AddResources> createState() => _AddResourcesState();
}

class _AddResourcesState extends State<AddResources> {
  File? file;
  bool _multiPick = true;
  String? selectedFile = "";
  String? fileType = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Add Resources"),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        YMargin(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Course Code",
                style: Config.b2(context).copyWith(
                  color: ProbitasColor.ProbitasTextSecondary,
                ),
              ),
              YMargin(10),
              ProbitasTextFormField(
                hintText: "Course Code",
              ),
            ],
          ),
        ),
        YMargin(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Course Title",
                style: Config.b2(context).copyWith(
                  color: ProbitasColor.ProbitasTextSecondary,
                ),
              ),
              YMargin(10),
              ProbitasTextFormField(
                hintText: "Course Title",
              ),
            ],
          ),
        ),
        YMargin(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Topic",
                style: Config.b2(context).copyWith(
                  color: ProbitasColor.ProbitasTextSecondary,
                ),
              ),
              YMargin(10),
              ProbitasTextFormField(
                hintText: "Course Topic",
              ),
            ],
          ),
        ),
        YMargin(10),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ProbitasSmallButton(
                title: "Upload File",
                icon: ImagesAsset.file,
                onTap: _openFileExplorer,
              )),
        ),
        YMargin(20),
        file != null
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50),
                height: 60,
                width: context.screenWidth(),
                decoration: BoxDecoration(
                    color: ProbitasColor.ProbitasSecondary,
                    borderRadius: BorderRadius.circular(12.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 6.0,
                        height: 40,
                        decoration: BoxDecoration(
                            color: ProbitasColor.ProbitasTextPrimary,
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      XMargin(15),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            YMargin(5.0),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                selectedFile.toString().trim(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Config.b2(context).copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            YMargin(2.0),
                            Text(
                              fileType.toString(),
                              style: Config.b2(context).copyWith(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
            : SizedBox.shrink()
      ])),
      floatingActionButton: InkWell(
        onTap: () {},
        child: Container(
          height: 70,
          width: 220,
          decoration: BoxDecoration(
              color: ProbitasColor.ProbitasSecondary,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Center(
            child: Text(
              "Add Material",
              style: Config.b2(context).copyWith(
                color: ProbitasColor.ProbitasTextPrimary,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: _multiPick,
        allowedExtensions: allowed);

    // ignore: unnecessary_null_comparison
    if (result != null && result.files.map((e) => e.path) != null) {
      setState(() {
        file = File(result.files.map((e) => e.name).toString());
        selectedFile = result.files.map((e) => e.name).toString();
        fileType = result.files.map((e) => e.extension).toString();
      });
    } else if (file == null) {
      Toasts.showErrorToast("No Document Selected");
    }
  }
}
