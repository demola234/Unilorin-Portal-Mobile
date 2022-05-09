import 'package:flutter/material.dart';

import '../../core/utils/customs/custom_appbar.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomAppbar(),
      ),
      body: Column(
        children: [
          Row(
            children: [
              
            ],
          )
        ],
      )
    );
  }
}
