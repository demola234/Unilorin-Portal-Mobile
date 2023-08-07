import 'dart:convert';
import 'package:probitas_app/features/dashboard/data/model/user_request.dart';

class UserResponse {
  UserResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  UserRequest? data;

  factory UserResponse.fromRawJson(String str) =>
      UserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        success: json["success"],
        message: json["message"],
        data: UserRequest.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
      };
}
