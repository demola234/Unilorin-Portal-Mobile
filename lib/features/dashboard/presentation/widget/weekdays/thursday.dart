import 'package:flutter/material.dart';

import '../schedule_tile.dart/schedule_tile.dart';

class Thursday extends StatelessWidget {
  const Thursday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Container(
            height: 400,
            child: ListView.builder(
                itemCount: 1,
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
