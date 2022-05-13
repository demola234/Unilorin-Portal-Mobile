import 'dart:convert';
import 'package:probitas_app/features/dashboard/data/model/user_request.dart';


class UserResponses {
  UserResponses({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory UserResponses.fromRawJson(String str) =>
      UserResponses.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResponses.fromJson(Map<String, dynamic> json) => UserResponses(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
      };
}
