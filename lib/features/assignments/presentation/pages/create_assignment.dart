import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/components.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'package:probitas_app/core/utils/states.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';
import '../provider/assignment_provider.dart';

class CreateAssignment extends ConsumerStatefulWidget {
  const CreateAssignment({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends ConsumerState<CreateAssignment> {
  TextEditingController courseCode = TextEditingController();
  TextEditingController courseTitle = TextEditingController();
  TextEditingController lecturesName = TextEditingController();
  TextEditingController topic = TextEditingController();
  TextEditingController dueDateTimeText = TextEditingController();
  late DateTime dueDateTime;

  var remindMe;

  @override
  void dispose() {
    super.dispose();
    courseCode.dispose();
    courseTitle.dispose();
    lecturesName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final assignmentState = ref.watch(assignmentNotifierProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Create Assignment"),
      ),
      body: Container(
        child: SingleChildScrollView(
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
                    controller: courseCode,
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
                    controller: courseTitle,
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
                    "Lecturers Name",
                    style: Config.b2(context).copyWith(
                      color: ProbitasColor.ProbitasTextSecondary,
                    ),
                  ),
                  YMargin(10),
                  ProbitasTextFormField(
                    hintText: "Lecturers Name",
                    controller: lecturesName,
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
                    hintText: "Topic",
                    controller: topic,
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
                    "Due Time",
                    style: Config.b2(context).copyWith(
                      color: ProbitasColor.ProbitasTextSecondary,
                    ),
                  ),
                  YMargin(10),
                  ProbitasTextFormField(
                    hintText: "8:00",
                    readOnly: true,
                    controller: dueDateTimeText,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        ImagesAsset.time,
                        height: 15,
                        width: 15,
                      ),
                    ),
                    onTap: _selectDateTime,
                  ),
                ],
              ),
            ),
            YMargin(60),
            InkWell(
                onTap: () {},
                child: ProbitasButton(
                  onTap: () async {
                    ref
                        .watch(assignmentNotifierProvider.notifier)
                        .createAssignment(
                          courseCode.text,
                          courseTitle.text,
                          lecturesName.text,
                          dueDateTime.toString(),
                          topic.text,
                        );
                  },
                  showLoading: assignmentState.viewState.isLoading,
                  text: "Create Schedule",
                )),
          ]),
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  _selectDateTime() async {
    final date = await _selectDate(context);
    // ignore: unnecessary_null_comparison
    if (date == null) return;

    final time = await _selectTime(context);
    // ignore: unnecessary_null_comparison
    if (time == null) return;

    setState(() {
      dueDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      String formattedTime =
          DateFormat.MMMMEEEEd().add_jm().format(dueDateTime);
      dueDateTimeText.text = formattedTime;
    });
  }

  // Select for Date
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

// Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }
}
