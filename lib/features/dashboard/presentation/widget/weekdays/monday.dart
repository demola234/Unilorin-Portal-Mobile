import 'package:flutter/material.dart';
import 'package:probitas_app/core/utils/config.dart';
import '../schedule_tile.dart/schedule_tile.dart';

class Monday extends StatelessWidget {
  const Monday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ScheduleTile();
                }),
          ),
        )
      ],
    );
  }
}
