import 'dart:io';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:probitas_app/core/error/toasts.dart';
import 'package:probitas_app/core/utils/components.dart';
import 'package:probitas_app/core/utils/config.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_path.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Add Posts"),
      ),
      body: Column(
        children: [
          YMargin(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Image(
                    image: AssetImage(ImagesAsset.default_image),
                  ),
                ),
                XMargin(10.0),
                Flexible(
                  child: ProbitasTextFormField(
                    hintText: "Say Something...",
                  ),
                ),
              ],
            ),
          ),
          YMargin(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: InkWell(
                    onTap: () {
                      if (images.length >= 5) {
                        Toasts.showErrorToast("Only 5 Images can be Selected");
                      } else {
                        selectImage();
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 90,
                      decoration: BoxDecoration(
                          color: ProbitasColor.ProbitasSecondary,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Add Images",
                              style: Config.b3(context).copyWith(
                                color: ProbitasColor.ProbitasTextPrimary,
                              )),
                        ],
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),
          YMargin(10),
          Expanded(
            child: Container(
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: context.screenWidth(),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: images
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Material(
                                    borderRadius: BorderRadius.circular(16.0),
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 5.0),
                                      height: 100,
                                      width: 120,
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: Image.file(
                                              e,
                                              fit: BoxFit.cover,
                                              height: 100,
                                              width: 120,
                                            ),
                                          ),
                                          Positioned(
                                              top: -10,
                                              right: -10,
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      images.remove(e);
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .cancel_presentation_rounded,
                                                    color: Colors.white,
                                                  )))
                                        ],
                                      ),
                                    )),
                              ))
                          .toList(),
                    ),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
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
              "Add Post",
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

  List<File> images = [];
  void selectImage() async {
    List<Media>? res = await ImagesPicker.pick(
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio.custom,
        cropType: CropType.rect,
      ),
      gif: true,
      count: 5 - images.length,
      pickType: PickType.image,
    );

    if (res != null) {
      setState(() {
        images.addAll(res.map((e) => File(e.path)));
      });
    } else if (res == null) {
      Toasts.showErrorToast("No Image Selected");
    }
  }
}
