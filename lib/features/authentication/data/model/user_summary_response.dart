import 'package:probitas_app/features/authentication/data/model/user_summary_request.dart';

class UserSummaryResponse {
  bool? success;
  String? message;
  UserSummaryRequest? data;

  UserSummaryResponse.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    message = json["message"];
    data = UserSummaryRequest.fromJson(json["data"] ?? Map<String, dynamic>());
  }
}
