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

class CreateAssignment extends ConsumerStatefulWidget {
  const CreateAssignment({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends ConsumerState<CreateAssignment> {
  TextEditingController courseCode = TextEditingController();
  TextEditingController courseTitle = TextEditingController();
  TextEditingController lecturesName = TextEditingController();
  TextEditingController dueTimeController = TextEditingController();

  DateTime? startText;
  DateTime? endText;

  var remindMe;

  @override
  void dispose() {
    super.dispose();
    courseCode.dispose();
    courseTitle.dispose();
    lecturesName.dispose();
    dueTimeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                    "Due Date",
                    style: Config.b2(context).copyWith(
                      color: ProbitasColor.ProbitasTextSecondary,
                    ),
                  ),
                  YMargin(10),
                  ProbitasDropDown(
                    hintText: "Choose Week days",
                    items: [
                      "Monday",
                      "Tuesday",
                      "Wednesday",
                      "Thursday",
                      "Friday"
                    ],
                    onChanged: (value) {
                      setState(() {
                        remindMe = value;
                      });
                    },
                    value: remindMe,
                  )
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
                    controller: dueTimeController,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        ImagesAsset.time,
                        height: 15,
                        width: 15,
                      ),
                    ),
                    onTap: startTime,
                  ),
                ],
              ),
            ),
            YMargin(60),
            InkWell(
                onTap: () {},
                child: ProbitasButton(
                  onTap: () async {},
                  // showLoading: dashboardState.viewState.isLoading,
                  text: "Create Schedule",
                )),
          ]),
        ),
      ),
    );
  }

  startTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: ProbitasColor.ProbitasSecondary,
                onPrimary: ProbitasColor.ProbitasTextPrimary,
                onSurface: ProbitasColor.ProbitasSecondary,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: ProbitasColor.ProbitasSecondary,
                ),
              ),
            ),
            child: child!,
          );
        });

    if (pickedTime != null) {
      print(pickedTime.format(context));
      DateTime parsedTime =
          DateFormat('HH:mm:ss').parse(pickedTime.format(context));
      String formattedTime = DateFormat.jm().format(parsedTime);
      print(formattedTime);

      setState(() {
        dueTimeController.text = formattedTime;
        startText = parsedTime;
        print("Its meee=> $startText");
      });
    } else {
      print("Time is not selected");
    }
  }
}
