import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'package:probitas_app/core/utils/navigation_service.dart';
import 'package:probitas_app/features/assignments/presentation/pages/get_single_submitted_assignment.dart';
import 'package:probitas_app/features/assignments/presentation/pages/widgets/assignment_tile.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';
import '../../../dashboard/presentation/widget/empty_state/empty_state.dart';
import '../controller/assignment_controller.dart';

class SubmittedAssignment extends ConsumerStatefulWidget {
  const SubmittedAssignment({Key? key}) : super(key: key);

  @override
  ConsumerState<SubmittedAssignment> createState() =>
      _SubmittedAssignmentState();
}

class _SubmittedAssignmentState extends ConsumerState<SubmittedAssignment> {
  @override
  Widget build(BuildContext context) {
    final value = ref.watch(getAssignmentProvider);
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Submitted Assignment"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(children: [
            YMargin(10),
            Expanded(
              child: Container(
                width: context.screenWidth(),
                child: value.when(
                  data: (data) => ListView.builder(
                      itemCount: data.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return AssignmentTile(
                          onTap: () => NavigationService()
                              .navigateToScreen(SubmittedAssignmentByUser(
                            assignmentId: data.data[index].id,
                            courseName: data.data[index].courseTitle,
                            courseCode: data.data[index].courseCode,
                          )),
                          courseCode: data.data[index].courseCode,
                          courseTitle: data.data[index].courseTitle,
                          dueDate: data.data[index].dueDate,
                          lecturer: data.data[index].lecturer,
                          assignmentId: data.data[index].id,
                        );
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
    );
  }
}
