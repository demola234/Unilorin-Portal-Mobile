import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:probitas_app/core/error/toasts.dart';
import 'package:probitas_app/core/utils/states.dart';
import 'package:probitas_app/features/assignments/presentation/controller/assignment_controller.dart';
import 'package:probitas_app/features/assignments/presentation/provider/assignment_provider.dart';
import 'package:probitas_app/features/posts/presentation/pages/posts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_path.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/allowed_extension.dart';
import '../../../../core/utils/components.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';
import '../../../dashboard/presentation/widget/empty_state/empty_state.dart';

class SubmitAssignment extends ConsumerStatefulWidget {
  final String assignmentId;
  SubmitAssignment({required this.assignmentId, Key? key}) : super(key: key);

  @override
  ConsumerState<SubmitAssignment> createState() => _SubmitAssignmentState();
}

class _SubmitAssignmentState extends ConsumerState<SubmitAssignment> {
  File? file;
  bool _multiPick = true;
  String? selectedFile = "";
  String? fileType = "";

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(getSingleAssignmentProvider(widget.assignmentId));
    final assignmentState = ref.watch(assignmentNotifierProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Submit Assignment"),
      ),
      body: SingleChildScrollView(
        child: value.when(
          data: (data) => Column(children: [
            YMargin(5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: SvgPicture.asset(ImagesAsset.book),
                    ),
                    XMargin(30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        YMargin(20.0),
                        Text(
                          data.data.assignment.courseCode.toUpperCase(),
                          style: Config.b2(context).copyWith(
                            color: isDarkMode
                                ? ProbitasColor.ProbitasTextPrimary
                                : ProbitasColor.ProbitasSecondary,
                            fontSize: 15,
                          ),
                        ),
                        YMargin(2.0),
                        Text(
                          data.data.assignment.courseTitle,
                          style: Config.b2(context).copyWith(
                            color: isDarkMode
                                ? ProbitasColor.ProbitasTextPrimary
                                : ProbitasColor.ProbitasSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            YMargin(15.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Spacer(),
                  ProbitasSmallButton(
                      onTap: _openFileExplorer, title: "Upload"),
                ],
              ),
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
          ]),
          loading: () => Align(
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(
                color: ProbitasColor.ProbitasSecondary,
              ),
            ),
          ),
          error: (err, str) => EmptyState(),
        ),
      ),
      floatingActionButton: ProbitasButton(
        onTap: acceptedInputs,
        text: "Add Material",
        showLoading: assignmentState.viewState.isLoading,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  acceptedInputs() async {
    try {
      if (file == null) {
        Toasts.showErrorToast("Select a resource");
        return;
      }
      await ref
          .watch(assignmentNotifierProvider.notifier)
          .submitAssignment(widget.assignmentId, file: file!);
    } catch (e) {
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    }
  }

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowCompression: true,
      allowedExtensions: allowedExtensions,
    );

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
        selectedFile = result.files.single.name;
        fileType = result.files.single.extension;
      });
    } else {
      // User canceled the picker
      Toasts.showErrorToast("No Document Selected");
    }
  }
}
