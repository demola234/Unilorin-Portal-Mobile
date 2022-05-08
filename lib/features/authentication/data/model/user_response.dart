import 'package:probitas_app/features/authentication/data/model/user_request.dart';

class UserResponse {
  late bool success;
  late String message;
  late UserRequest data;

  UserResponse.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    message = json["message"];
    data = UserRequest.fromJson(json["userRequest"] ?? Map<String, dynamic>());
  }
}
