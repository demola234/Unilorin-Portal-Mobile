import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/navigation_service.dart';
import '../../../../bottom_navigation.dart';
import '../../../data/model/user_request.dart';
import '../../provider/authentication_provider.dart';
import 'authentication.dart';

class LoggerScreen extends ConsumerWidget {
  LoggerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder<UserRequest>(
          future: ref
              .read(authenticationNotifierProvider.notifier)
              .getUserFromCache(),
          builder: (context, snapshot) {
            if (snapshot.hasData ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return NavController();
              } else {
                return Authentication();
              }
            }
            return Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          }),
    ));
  }
}
