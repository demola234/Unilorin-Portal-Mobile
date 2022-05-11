import 'package:flutter/material.dart';

import '../schedule_tile.dart/schedule_tile.dart';

class Thursday extends StatelessWidget {
  const Thursday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: ListView.builder(
                itemCount: 10,
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
