import 'package:flutter/material.dart';
import 'package:probitas_app/features/dashboard/presentation/widget/empty_state/empty_state.dart';

class Tuesday extends StatelessWidget {
  const Tuesday({Key? key}) : super(key: key);

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
                  return EmptyState();
                }),
          ),
        )
      ],
    );
  }
}
