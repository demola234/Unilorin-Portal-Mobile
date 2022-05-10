import 'package:flutter/material.dart';
import '../schedule_tile.dart/schedule_tile.dart';

class Monday extends StatelessWidget {
  const Monday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Container(
            height: 400,
            child: ListView.builder(
                itemCount: 5,
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
