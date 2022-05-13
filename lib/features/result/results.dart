import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/image_path.dart';
import '../../core/utils/components.dart';
import '../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';

class Result extends StatefulWidget {
  Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  bool isVisible = false;
  bool isResult = false;
  var session, semester;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Result"),
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 100,
          width: context.screenWidth(),
          decoration: BoxDecoration(
              color: ProbitasColor.ProbitasTextPrimary.withOpacity(0.5),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: Image(
                        image: AssetImage(ImagesAsset.default_image),
                      ),
                    ),
                    XMargin(20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Femi Ademola",
                          maxLines: 1,
                          style: Config.b2(context).copyWith(
                              color: isDarkMode
                                  ? Colors.white
                                  : ProbitasColor.ProbitasPrimary),
                        ),
                        YMargin(2.0),
                        Text(
                          "First Semester",
                          style: Config.b2(context).copyWith(
                              color: isDarkMode
                                  ? ProbitasColor.ProbitasTextPrimary
                                  : ProbitasColor.ProbitasTextSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "CGPA",
                    style: Config.b2(context).copyWith(
                        color: isDarkMode
                            ? Colors.white
                            : ProbitasColor.ProbitasPrimary),
                  ),
                  YMargin(2.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(ImagesAsset.calculator,
                            color: isDarkMode
                                ? ProbitasColor.ProbitasTextPrimary
                                : ProbitasColor.ProbitasTextSecondary),
                        XMargin(2),
                        Text(
                          isVisible ? "4.34" : "---",
                          style: Config.b2(context).copyWith(
                              color: isDarkMode
                                  ? ProbitasColor.ProbitasTextPrimary
                                  : ProbitasColor.ProbitasTextSecondary),
                        ),
                      ],
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
                "Choose Session",
                style: Config.b2(context).copyWith(
                  color: ProbitasColor.ProbitasTextSecondary,
                ),
              ),
              YMargin(10),
              ProbitasDropDown(
                hintText: "2021/2022",
                items: [
                  "2021/2022",
                  "2020/2021",
                  "2019/2020",
                  "2018/2019",
                  "2017/2018",
                  "2016/2017",
                  "2015/2016",
                  "2014/2015",
                  "2013/2014",
                  "2012/2011",
                  "2010/2009",
                ],
                onChanged: (value) {
                  setState(() {
                    session = value;
                  });
                },
                value: session,
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
                "Choose Semester",
                style: Config.b2(context).copyWith(
                  color: ProbitasColor.ProbitasTextSecondary,
                ),
              ),
              YMargin(10),
              ProbitasDropDown(
                hintText: "First Semester",
                items: [
                  "First Semester",
                  "Second Semester",
                ],
                onChanged: (value) {
                  setState(() {
                    semester = value;
                  });
                },
                value: semester,
              )
            ],
          ),
        ),
        YMargin(30),
        InkWell(
          onTap: () {
            setState(() {
              isResult = true;
            });
          },
          child: Container(
            height: 70,
            width: 220,
            decoration: BoxDecoration(
                color: ProbitasColor.ProbitasSecondary,
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Center(
              child: Text(
                "Get Result",
                style: Config.b2(context).copyWith(
                  color: ProbitasColor.ProbitasTextPrimary,
                ),
              ),
            ),
          ),
        ),
        YMargin(20),
        isResult == true ? GetResults() : SizedBox.shrink(),
      ]),
    );
  }
}

class GetResults extends StatelessWidget {
  const GetResults({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: DataTable(
                        dividerThickness: 1,
                        columnSpacing: 22,
                        sortColumnIndex: 1,
                        sortAscending: true,
                        columns: [
                          DataColumn(
                            label: Text(
                              'Code',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Config.b3(context),
                            ),
                            numeric: false,
                            tooltip: 'Course Code',
                          ),
                          DataColumn(
                            label: Text(
                              'Status',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Config.b3(context),
                            ),
                            numeric: false,
                            tooltip: 'Status',
                          ),
                          DataColumn(
                            label: Text(
                              'Unit',
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              style: Config.b3(context),
                            ),
                            numeric: false,
                            tooltip: 'Unit',
                          ),
                          DataColumn(
                            label: Text(
                              'Ca',
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              style: Config.b3(context),
                            ),
                            numeric: false,
                            tooltip: 'Ca',
                          ),
                          DataColumn(
                            label: Text(
                              'Exam',
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              style: Config.b3(context),
                            ),
                            numeric: false,
                            tooltip: 'Exam',
                          ),
                          DataColumn(
                            label: Text(
                              'Total',
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              style: Config.b3(context),
                            ),
                            numeric: false,
                            tooltip: 'Total',
                          ),
                          DataColumn(
                            label: Text(
                              'Grade',
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              style: Config.b3(context),
                            ),
                            numeric: false,
                            tooltip: 'Grade',
                          ),
                        ],
                        rows: [
                          //TODO 3:For Loop to return DataSnapShots
                          for (int i = 1; i <= 10; i++)
                            DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    'LIS212',
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: Config.b3(context),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    'C',
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: Config.b3(context),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '2',
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: Config.b3(context),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '30',
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: Config.b3(context),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '50',
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: Config.b3(context),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '80',
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: Config.b3(context),
                                  ),
                                ),
                                DataCell(Row(
                                  children: [
                                    Text(
                                      'A',
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      style: Config.b3(context),
                                    ),
                                  ],
                                )),
                              ].toList(),
                            ),
                        ],
                      ))
                ])
              ])),
    );
  }
}
