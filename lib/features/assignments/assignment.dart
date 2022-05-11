import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/utils/config.dart';
import '../../core/utils/customs/custom_appbar.dart';
import '../../core/utils/customs/custom_drawers.dart';

class Assignment extends StatefulWidget {
  const Assignment({Key? key}) : super(key: key);

  @override
  State<Assignment> createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: CustomAppbar(
            onPressed: () {
              _key.currentState!.openDrawer();
            },
          ),
        ),
        drawer: ProbitasDrawer(),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
              YMargin(10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Your Assignments",
                  style: Config.h3(context).copyWith(
                    color: ProbitasColor.ProbitasPrimary,
                    fontSize: 18,
                  ),
                ),
              ]),
              YMargin(10),
              Expanded(
                  child: Container(
                      width: context.screenWidth(),
                      child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              height: 140,
                              width: context.screenWidth(),
                              decoration: BoxDecoration(
                                  color: ProbitasColor.ProbitasTextSecondary,
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 6.0,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color:
                                              ProbitasColor.ProbitasTextPrimary,
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                    ),
                                    XMargin(15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        YMargin(20.0),
                                        Text(
                                          "LIS121",
                                          style: Config.b2(context).copyWith(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        YMargin(2.0),
                                        Text(
                                          "Library and Information Techniques",
                                          style: Config.b2(context).copyWith(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                "Due Date: Jun 10, 2022, 9:00 AM",
                                                style:
                                                    Config.b2(context).copyWith(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                )),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text("By Stephen Peter",
                                                style:
                                                    Config.b2(context).copyWith(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                )),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          })))
            ])));
  }
}

class AssignmentTile extends StatelessWidget {
  const AssignmentTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
