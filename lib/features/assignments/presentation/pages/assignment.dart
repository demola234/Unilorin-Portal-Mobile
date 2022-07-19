import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:probitas_app/features/assignments/presentation/pages/submit_assignment.dart';
import 'package:probitas_app/features/assignments/presentation/pages/submited_assignment.dart';
import 'package:probitas_app/features/assignments/presentation/pages/widgets/assignment_tile.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_appbar.dart';
import '../../../../core/utils/customs/custom_drawers.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';
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
                                  onTap: () {
                                    NavigationService().navigateToScreen(
                                        SubmitAssignment(
                                            assignmentId: data.data[index].id));
                                  },
                                  courseCode: data.data[index].courseCode,
                                  courseTitle: data.data[index].courseTitle,
                                  dueDate: data.data[index].dueDate,
                                  lecturer: data.data[index].lecturer,
                                  assignmentId: data.data[index].id,
                                )
                              : data.data.length > 2
                                  ? Container()
                                  : Container();
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
                        labelBackgroundColor: isDarkMode
                            ? ProbitasColor.ProbitasSecondary
                            : ProbitasColor.ProbitasTextPrimary,
                        elevation: 0,
                        label: 'Submitted Assignment',
                        labelStyle: TextStyle(fontSize: 18.0),
                        onTap: () => NavigationService()
                            .navigateToScreen(SubmittedAssignment()),
                        onLongPress: () => NavigationService()
                            .navigateToScreen(SubmittedAssignment())),
                    SpeedDialChild(
                      //speed dial child
                      child: Icon(Icons.add),
                      backgroundColor: ProbitasColor.ProbitasSecondary,
                      foregroundColor: Colors.white,
                      label: 'Create Assignment',
                      labelStyle: TextStyle(fontSize: 18.0),
                      labelBackgroundColor: isDarkMode
                          ? ProbitasColor.ProbitasSecondary
                          : ProbitasColor.ProbitasTextPrimary,
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
