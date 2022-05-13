import 'package:probitas_app/features/authentication/data/model/user_request.dart';

class UserResponse {
   bool? success;
   String? message;
   UserRequest? data;

  UserResponse.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    message = json["message"];
    data = UserRequest.fromJson(json["data"] ?? Map<String, dynamic>());
  }
}
