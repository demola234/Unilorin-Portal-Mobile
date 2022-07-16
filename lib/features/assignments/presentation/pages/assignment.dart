import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:probitas_app/features/assignments/presentation/pages/submit_assignment.dart';
import 'package:probitas_app/features/assignments/presentation/pages/submitted_assignment.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_appbar.dart';
import '../../../../core/utils/customs/custom_drawers.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';
import '../../../dashboard/presentation/pages/manage_schedules.dart';
import '../../../dashboard/presentation/widget/empty_state/empty_state.dart';
import '../controller/assignment_controller.dart';
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
    final value = ref.watch(getAssignmentProvider);
    final getUser = ref.watch(getUsersProvider);
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
                  child: value.when(
                    data: (data) => ListView.builder(
                        itemCount: data.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return data.data[index].dueDate
                                  .isAfter(DateTime.now())
                              ? AssignmentTile(
                                  courseCode: data.data[index].courseCode,
                                  courseTitle: data.data[index].courseTitle,
                                  dueDate: data.data[index].dueDate,
                                  lecturer: data.data[index].lecturer,
                                  assignmentId: data.data[index].id,
                                )
                              : SizedBox.fromSize();
                        }),
                    loading: () => Center(
                      child: CircularProgressIndicator(
                        color: ProbitasColor.ProbitasSecondary,
                      ),
                    ),
                    error: (err, str) => EmptyState(),
                  ),
                ),
              )
            ])),
        floatingActionButton: getUser.when(
          data: (data) => data.data!.user!.user!.role == "CLASS_REP"
              ? SpeedDial(
                  marginBottom: 10,
                  icon: Icons.add,
                  activeIcon: Icons.close,
                  backgroundColor: ProbitasColor.ProbitasSecondary,
                  foregroundColor: Colors.white,
                  activeBackgroundColor: ProbitasColor.ProbitasTextPrimary,
                  activeForegroundColor: ProbitasColor.ProbitasSecondary,
                  buttonSize: 56.0,
                  visible: true,
                  closeManually: true,
                  curve: Curves.bounceIn,
                  overlayColor: Colors.black,
                  overlayOpacity: 0.5,
                  elevation: 0,
                  shape: CircleBorder(),
                  children: [
                    SpeedDialChild(
                      child: Icon(Icons.book_online),
                      backgroundColor: ProbitasColor.ProbitasSecondary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      label: 'Submitted Assignment',
                      labelStyle: TextStyle(fontSize: 18.0),
                      onTap: () => NavigationService()
                          .navigateToScreen(SubmittedAssignment()),
                      onLongPress: () => NavigationService()
                          .navigateToScreen(SubmittedAssignment()),
                    ),
                    SpeedDialChild(
                      //speed dial child
                      child: Icon(Icons.add),
                      backgroundColor: ProbitasColor.ProbitasSecondary,
                      foregroundColor: Colors.white,
                      label: 'Create Assignment',
                      labelStyle: TextStyle(fontSize: 18.0),
                      elevation: 0,
                      onTap: () => NavigationService()
                          .navigateToScreen(CreateAssignment()),
                      onLongPress: () => NavigationService()
                          .navigateToScreen(CreateAssignment()),
                    ),
                  ],
                )
              : Container(),
          loading: () => Container(),
          error: (_, err) => Container(),
        ));
  }
}

class AssignmentTile extends StatelessWidget {
  String courseCode;
  String courseTitle;
  DateTime dueDate;
  String lecturer;
  String assignmentId;
  AssignmentTile({
    required this.courseCode,
    required this.courseTitle,
    required this.dueDate,
    required this.lecturer,
    required this.assignmentId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => NavigationService().navigateToScreen(SubmitAssignment(
              assignmentId: assignmentId,
            )),
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
                      courseCode,
                      style: Config.b2(context).copyWith(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    YMargin(2.0),
                    Text(
                      courseTitle,
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
                        Text(DateFormat.MMMMEEEEd().add_jm().format(dueDate),
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
                        Text("By $lecturer",
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
        ));
  }
}
