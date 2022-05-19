import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:probitas_app/core/constants/colors.dart';
import '../../controller/dashboard_controller.dart';
import '../empty_state/empty_state.dart';
import '../schedule_tile.dart/schedule_tile.dart';

class Monday extends ConsumerWidget {
  Monday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(getSchedulesProvider);

    return Column(
      children: [
        Expanded(
            child: value.when(
          data: (data) => Container(
            child: data.data!.schedules![0].weekdays![0].contains("Mons")
                ? ListView.builder(
                    itemCount: data.data!.schedules!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ScheduleTile(
                        courseCode: data.data!.schedules![index].courseCode!,
                        courseTitle: data.data!.schedules![index].courseTitle!,
                        venue: data.data!.schedules![index].venue!,
                        startTime: data.data!.schedules![index].startTime!,
                        endTime: data.data!.schedules![index].endTime!,
                      );
                    })
                : Column(
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          height: 400,
                          child: ListView.builder(
                              itemCount: 1,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return EmptyState();
                              }),
                        ),
                      )
                    ],
                  ),
          ),
          error: (err, str) => EmptyState(),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: ProbitasColor.ProbitasSecondary,
            ),
          ),
        ))
      ],
    );
  }
}
