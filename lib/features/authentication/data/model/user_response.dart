import 'dart:convert';

import 'package:probitas_app/features/authentication/data/model/user_request.dart';

class UserResponse {
  late bool success;
  late String message;
  late UserRequest userRequest;

  UserResponse.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    message = json["message"];
    userRequest = UserRequest.fromJson(json["userRequest"]);
  }
}
