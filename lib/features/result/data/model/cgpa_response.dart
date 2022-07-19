import 'dart:convert';

class CgpaResponse {
  CgpaResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory CgpaResponse.fromRawJson(String str) =>
      CgpaResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CgpaResponse.fromJson(Map<String, dynamic> json) => CgpaResponse(
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

class Data {
  Data({
    this.cgpa,
  });

  dynamic cgpa;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cgpa: json["cgpa"],
      );

  Map<String, dynamic> toJson() => {
        "cgpa": cgpa,
      };
}
