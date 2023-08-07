import 'dart:convert';
import 'package:probitas_app/features/dashboard/data/model/user_summary_request.dart';

class UserSummaryResponse {
  UserSummaryResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  UserSummaryRequest? data;

  factory UserSummaryResponse.fromRawJson(String str) =>
      UserSummaryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSummaryResponse.fromJson(Map<String, dynamic> json) =>
      UserSummaryResponse(
        success: json["success"],
        message: json["message"],
        data: UserSummaryRequest.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
      };
}
