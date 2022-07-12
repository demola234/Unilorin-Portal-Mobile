import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/error/toasts.dart';
import 'package:probitas_app/core/utils/states.dart';
import 'package:probitas_app/features/assignments/presentation/controller/assignment_controller.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/allowed_extension.dart';
import '../../../../core/utils/components.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';
import '../../../dashboard/presentation/widget/empty_state/empty_state.dart';
import '../../../posts/presentation/pages/posts.dart';
import '../../../resources/presentation/provider/resources_provider.dart';

class SubmitAssignment extends ConsumerStatefulWidget {
  final String assignmenttId;
  SubmitAssignment({required this.assignmenttId, Key? key}) : super(key: key);

  @override
  ConsumerState<SubmitAssignment> createState() => _SubmitAssignmentState();
}

class _SubmitAssignmentState extends ConsumerState<SubmitAssignment> {
  late File file;
  bool _multiPick = true;
  String? selectedFile = "";
  String? fileType = "";

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(getSingleAssignmentProvider(widget.assignmenttId));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Submit Assignment"),
      ),
      body: SingleChildScrollView(
          child:
          
          value.when(
                  data: (data) => Column(children: [
        YMargin(5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(20.0),
                Text(
                  "LIS121",
                  style: Config.b2(context).copyWith(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                YMargin(2.0),
                Text(
                  "Library and Information Techniques",
                  style: Config.b2(context).copyWith(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
        YMargin(15.0),
        ProbitasButton(onTap: _openFileExplorer, text: "Upload Assignment"),
        YMargin(20),
        // file != null
        //     ? Container(
        //         margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50),
        //         height: 60,
        //         width: context.screenWidth(),
        //         decoration: BoxDecoration(
        //             color: ProbitasColor.ProbitasSecondary,
        //             borderRadius: BorderRadius.circular(12.0)),
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //           child: Row(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Container(
        //                 width: 6.0,
        //                 height: 40,
        //                 decoration: BoxDecoration(
        //                     color: ProbitasColor.ProbitasTextPrimary,
        //                     borderRadius: BorderRadius.circular(12.0)),
        //               ),
        //               XMargin(15),
        //               Flexible(
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     YMargin(5.0),
        //                     Flexible(
        //                       fit: FlexFit.loose,
        //                       child: Text(
        //                         selectedFile.toString().trim(),
        //                         overflow: TextOverflow.ellipsis,
        //                         maxLines: 1,
        //                         style: Config.b2(context).copyWith(
        //                           color: Colors.white,
        //                           fontSize: 12,
        //                         ),
        //                       ),
        //                     ),
        //                     YMargin(2.0),
        //                     Text(
        //                       fileType.toString(),
        //                       style: Config.b2(context).copyWith(
        //                         color: Colors.white,
        //                         fontSize: 12,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               )
        //             ],
        //           ),
        //         ))
        //     : SizedBox.shrink()
      ]),
      loading: () => Center(
                    child: CircularProgressIndicator(
                      color: ProbitasColor.ProbitasSecondary,
                    ),
                  ),
                  error: (err, str) => EmptyState(),
          ),
      ),
      floatingActionButton: ProbitasButton(
        onTap: () {},
        text: "Add Material",
        // showLoading: resourcesState.viewState.isLoading,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // acceptedInputs() async {
  //   try {
  //     var courseCodeText = courseCode.text;
  //     var courseTitleText = courseTitle.text;
  //     var topicText = topic.text;
  //     if (courseCodeText.trim().isEmpty && courseCodeText.length > 6) {
  //       Toasts.showErrorToast("Please pick a Proper Course Code");
  //       return;
  //     } else if (courseTitleText.trim().isEmpty &&
  //         courseTitleText.length >= 8) {
  //       Toasts.showErrorToast(
  //           "Your Course name cannot be shorter than 8 Characters");
  //       return;
  //     } else if (file == null) {
  //       Toasts.showErrorToast("Select a resource");
  //       return;
  //     } else if (topicText.trim().isEmpty) {
  //       Toasts.showErrorToast(
  //           "You must write a short description of your topic");
  //       return;
  //     }
  //     await ref
  //         .watch(resourcesNotifierProvider.notifier)
  //         .createResource(courseCode.text, courseTitle.text, topic.text, file!);
  //     // ref.refresh(getResourcesNotifier);
  //   } catch (e) {
  //     Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
  //   }
  // }

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: allowedExtensions);

    // ignore: unnecessary_null_comparison
    if (result != null && result.files.map((e) => e.path) != null) {
      setState(() {
        file = File(result.files.single.path!);
        selectedFile = result.files.single.name;
        fileType = result.files.single.extension;
      });
    } else if (file == null) {
      Toasts.showErrorToast("No Document Selected");
    }
  }
}
