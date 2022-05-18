import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/components.dart';
import 'package:probitas_app/core/utils/config.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';
import '../provider/dashboard_provider.dart';

class ManageSchedule extends ConsumerStatefulWidget {
  const ManageSchedule({Key? key}) : super(key: key);

  @override
  ConsumerState<ManageSchedule> createState() => _ManageScheduleState();
}

class _ManageScheduleState extends ConsumerState<ManageSchedule> {
  TextEditingController courseCode = TextEditingController();
  TextEditingController courseTitle = TextEditingController();
  TextEditingController courseVenue= TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  DateTime? startText;
  DateTime? endText;

  // String?
  var remindMe;

@override
  void dispose() {
    super.dispose();
    courseCode.dispose();
    courseTitle.dispose();
    courseVenue.dispose();
    note.dispose();
    startController.dispose();
    endController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Add Schedule"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    "Venue",
                    style: Config.b2(context).copyWith(
                      color: ProbitasColor.ProbitasTextSecondary,
                    ),
                  ),
                  YMargin(10),
                  ProbitasTextFormField(
                    hintText: "Course Venue",
                    controller: courseVenue,
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
                    "Date",
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
                    "Date",
                    style: Config.b2(context).copyWith(
                      color: ProbitasColor.ProbitasTextSecondary,
                    ),
                  ),
                  YMargin(10),
                  Row(
                    children: [
                      Flexible(
                        child: ProbitasTextFormField(
                          hintText: "8:00",
                          readOnly: true,
                          controller: startController,
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
                      ),
                      XMargin(15),
                      Flexible(
                        child: ProbitasTextFormField(
                          hintText: "10:00",
                          readOnly: true,
                          controller: endController,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              ImagesAsset.time,
                              height: 15,
                              width: 15,
                            ),
                          ),
                          onTap: endTime,
                        ),
                      ),
                    ],
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
                    "Note",
                    style: Config.b2(context).copyWith(
                      color: ProbitasColor.ProbitasTextSecondary,
                    ),
                  ),
                  YMargin(10),
                  ProbitasTextFormField(
                    hintText: "Short Note",
                    controller: note,
                  ),
                ],
              ),
            ),
            YMargin(15),
            InkWell(
              onTap: () {
               ref.watch(dashboardNotifierProvider.notifier).createSchedule(courseCode.text, courseTitle.text, courseVenue.text, remindMe, startText.toString(), endText.toString(), note.text);
              },
              child: Container(
                height: 70,
                width: 220,
                decoration: BoxDecoration(
                    color: ProbitasColor.ProbitasSecondary,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Center(
                  child: Text(
                    "Create Schedule",
                    style: Config.b2(context).copyWith(
                      color: ProbitasColor.ProbitasTextPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
                )}
    );
 
    if (pickedTime != null) {
      print(pickedTime.format(context));
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      // print(parsedTime);
      String formattedTime = DateFormat('HH:mm').format(parsedTime);
      print(formattedTime);

      setState(() {
        startController.text = pickedTime.format(context);
        startText = parsedTime;
        print("Its meee=> $startText");
      });
    } else {
      print("Time is not selected");
    }
  }

  endTime() async {
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
                )}
    );


    if (pickedTime != null) {
      print(pickedTime.format(context));
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());

      print(parsedTime);
      String formattedTime = DateFormat('HH:mm').format(parsedTime);
      print(formattedTime);

      setState(() {
        endController.text = pickedTime.format(context);
        endText = parsedTime;
      });
    } else {
      print("Time is not selected");
    }
  }
}
