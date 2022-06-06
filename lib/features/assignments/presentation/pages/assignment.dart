import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:probitas_app/features/assignments/presentation/pages/submit_assignment.dart';
import 'package:probitas_app/features/assignments/presentation/pages/submitted_assignment.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_appbar.dart';
import '../../../../core/utils/customs/custom_drawers.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';
import '../../../dashboard/presentation/pages/manage_schedules.dart';
import 'create_assignment.dart';

class Assignment extends ConsumerStatefulWidget {
  const Assignment({Key? key}) : super(key: key);

  @override
  ConsumerState<Assignment> createState() => _AssignmentState();
}

class _AssignmentState extends ConsumerState<Assignment> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                  color: isDarkMode
                      ? ProbitasColor.ProbitasTextPrimary
                      : ProbitasColor.ProbitasPrimary,
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
                          return AssignmentTile();
                        })))
          ])),
      floatingActionButton: Visibility(
        // visible: ref.watch(getUsersProvider).asData!.value.data!.user.role,
        child: SpeedDial(
          //Speed dial menu
          marginBottom: 10, //margin bottom
          icon: Icons.add, //icon on Floating action button
          activeIcon: Icons.close, //icon when menu is expanded on button
          backgroundColor:
              ProbitasColor.ProbitasSecondary, //background color of button
          foregroundColor: Colors.white, //font color, icon color in button
          activeBackgroundColor: ProbitasColor
              .ProbitasTextPrimary, //background color when menu is expanded
          activeForegroundColor: ProbitasColor.ProbitasSecondary,
          buttonSize: 56.0, //button size
          visible: true,
          closeManually: true,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,

          elevation: 0, //shadow elevation of button
          shape: CircleBorder(), //shape of button
          children: [
            SpeedDialChild(
              child: Icon(Icons.book_online),
              backgroundColor: ProbitasColor.ProbitasSecondary,
              foregroundColor: Colors.white,
              elevation: 0,
              label: 'Submitted Assignment',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () =>
                  NavigationService().navigateToScreen(SubmittedAssignment()),
              onLongPress: () =>
                  NavigationService().navigateToScreen(SubmittedAssignment()),
            ),
            SpeedDialChild(
              //speed dial child
              child: Icon(Icons.add),
              backgroundColor: ProbitasColor.ProbitasSecondary,
              foregroundColor: Colors.white,
              label: 'Create Assignment',
              labelStyle: TextStyle(fontSize: 18.0),
              elevation: 0,
              onTap: () =>
                  NavigationService().navigateToScreen(CreateAssignment()),
              onLongPress: () =>
                  NavigationService().navigateToScreen(CreateAssignment()),
            ),
          ],
        ),
      ),
    );
  }
}

class AssignmentTile extends StatelessWidget {
  const AssignmentTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationService().navigateToScreen(SubmitAssignment()),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        height: 140,
        width: context.screenWidth(),
        decoration: BoxDecoration(
            color: ProbitasColor.ProbitasTextSecondary,
            borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 6.0,
                height: 100,
                decoration: BoxDecoration(
                    color: ProbitasColor.ProbitasTextPrimary,
                    borderRadius: BorderRadius.circular(12.0)),
              ),
              XMargin(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Due Date: Jun 10, 2022, 9:00 AM",
                          style: Config.b2(context).copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("By Stephen Peter",
                          style: Config.b2(context).copyWith(
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
      ),
    );
  }
}
