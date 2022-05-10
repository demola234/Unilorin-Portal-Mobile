import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/components.dart';
import 'package:probitas_app/core/utils/config.dart';

import '../../../posts/presentation/pages/post_overview.dart';

class ManageSchedule extends StatefulWidget {
  const ManageSchedule({Key? key}) : super(key: key);

  @override
  State<ManageSchedule> createState() => _ManageScheduleState();
}

class _ManageScheduleState extends State<ManageSchedule> {
  TextEditingController dateController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  @override
  void initState() {
    dateController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    "Venue",
                    style: Config.b2(context).copyWith(
                      color: ProbitasColor.ProbitasTextSecondary,
                    ),
                  ),
                  YMargin(10),
                  ProbitasTextFormField(
                    hintText: "Course Venue",
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
                  ProbitasTextFormField(
                    hintText: "Choose Week days",
                    readOnly: true,
                    controller: dateController,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        ImagesAsset.date,
                        height: 15,
                        width: 15,
                      ),
                    ),
                    onTap: pickDate,
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
                              height: 10,
                              width: 10,
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
                  ),
                ],
              ),
            ),
            YMargin(15),
            InkWell(
              onTap: () {},
              child: Container(
                height: 70,
                width: 220,
                decoration: BoxDecoration(
                    color: ProbitasColor.ProbitasSecondry,
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

  void pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      print(formattedDate);

      setState(() {
        dateController.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  startTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      String formattedTime = DateFormat('HH:mm').format(parsedTime);
      print(formattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.

      setState(() {
        startController.text = formattedTime;
      });
    } else {
      print("Time is not selected");
    }
  }

  endTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      String formattedTime = DateFormat('HH:mm').format(parsedTime);
      print(formattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.

      setState(() {
        endController.text = formattedTime;
      });
    } else {
      print("Time is not selected");
    }
  }
}
