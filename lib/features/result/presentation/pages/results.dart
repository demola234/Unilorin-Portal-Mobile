import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:probitas_app/core/utils/features.dart';
import 'package:probitas_app/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:probitas_app/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:probitas_app/features/result/data/model/result_response.dart';
import 'package:probitas_app/features/result/presentation/controller/result_controller.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_path.dart';
import '../../../../core/utils/components.dart';
import '../../../../core/utils/config.dart';
import '../../../../../../core/utils/customs/custom_nav_bar.dart';
import '../../../../core/utils/shimmer_loading.dart';

class Results extends ConsumerStatefulWidget {
  Results({Key? key}) : super(key: key);

  @override
  ConsumerState<Results> createState() => _ResultsState();
}

class _ResultsState extends ConsumerState<Results> {
  bool isVisible = false;
  bool isResult = false;
  final sessions = getSessions();
  var currentSession = getSessions()[0];

  @override
  Widget build(BuildContext context) {
    final userDetails = ref.watch(getUserSummaryProvider);
    final cgpaDetails = ref.watch(getCgpaProvider);
    final resultDetails = ref.watch(getResultsProvider(currentSession));

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
          ),
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
                        child: userDetails.when(
                            data: (data) => ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fitWidth,
                                    imageUrl: data.data!.user!.avatar!,
                                  ),
                                ),
                            error: (err, str) => Text("error"),
                            loading: () => Loading(
                                  height: 60,
                                  width: 60,
                                ))),
                    XMargin(20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userDetails.when(
                              data: (data) => data.data!.user!.fullName!,
                              error: (err, str) => "error",
                              loading: () => "loading"),
                          maxLines: 1,
                          style: Config.b2(context).copyWith(
                              color: isDarkMode
                                  ? Colors.white
                                  : ProbitasColor.ProbitasPrimary),
                        ),
                        YMargin(2.0),
                        Text(
                          userDetails.when(
                              data: (data) =>
                                  "${data.data!.user!.semester!.type!} Semester",
                              error: (err, str) => "error",
                              loading: () => "loading"),
                          maxLines: 1,
                          style: Config.b2(context).copyWith(
                              color: isDarkMode
                                  ? Colors.white
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
                          cgpaDetails.when(
                              data: (data) =>
                                  isVisible ? "${data.data!.cgpa}" : "---",
                              error: (err, str) => "---",
                              loading: () => "---"),
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
                hintText: currentSession,
                items: sessions,
                onChanged: (value) {
                  setState(() {
                    currentSession = value!;
                  });
                },
                value: currentSession,
              )
            ],
          ),
        ),
        resultDetails.when(
            data: (data) => GetResults(result: data.data!.result!),
            error: (err, str) => Text("err"),
            loading: () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    YMargin(100),
                    Align(
                        alignment: Alignment.center,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ProbitasColor.ProbitasSecondary,
                          ),
                        )),
                  ],
                ))
      ]),
    );
  }
}

class GetResults extends StatelessWidget {
  List<Result> result;
  RegExp regex = RegExp(r'([.]*00)(?!.*\d)');
  GetResults({
    required this.result,
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
                        columnSpacing: 15,
                        sortColumnIndex: 1,
                        sortAscending: true,
                        columns: [
                          DataColumn(
                            label: Text(
                              'Title',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Config.b3(context),
                            ),
                            numeric: false,
                            tooltip: 'Title',
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
                        rows: List.generate(result.length, (index) {
                          return DataRow(cells: [
                            DataCell(
                              Text(
                                result[index].title!.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                                style: Config.b3(context),
                              ),
                            ),
                            DataCell(
                              Text(
                                result[index].status?.name ?? '-',
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                                style: Config.b3(context),
                              ),
                            ),
                            DataCell(
                              Text(
                                result[index].unit!.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                                style: Config.b3(context),
                              ),
                            ),
                            DataCell(
                              Text(
                                result[index]
                                    .ca!
                                    .toString()
                                    .replaceAll(regex, ' '),
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                                style: Config.b3(context),
                              ),
                            ),
                            DataCell(
                              Text(
                                result[index]
                                    .exam!
                                    .toString()
                                    .replaceAll(regex, ' '),
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                                style: Config.b3(context),
                              ),
                            ),
                            DataCell(
                              Text(
                                result[index].total!.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                                style: Config.b3(context),
                              ),
                            ),
                            DataCell(Row(
                              children: [
                                Text(
                                  result[index].grade!.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.visible,
                                  style: Config.b3(context),
                                ),
                              ],
                            )),
                          ]);
                        }),
                      ))
                ])
              ])),
    );
  }
}
