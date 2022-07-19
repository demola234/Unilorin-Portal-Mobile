// To parse this JSON data, do
//
//     final resultResponse = resultResponseFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

class ResultResponse {
  ResultResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory ResultResponse.fromRawJson(String str) =>
      ResultResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultResponse.fromJson(Map<String, dynamic> json) => ResultResponse(
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
    this.result,
  });

  List<Result>? result;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        result:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.semester,
    this.code,
    this.title,
    this.unit,
    this.status,
    this.ca,
    this.exam,
    this.total,
    this.grade,
  });

  Semester? semester;
  String? code;
  String? title;
  String? unit;
  Status? status;
  String? ca;
  String? exam;
  String? total;
  String? grade;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        semester: semesterValues.map![json["semester"]],
        code: json["code"],
        title: json["title"],
        unit: json["unit"],
        status: statusValues.map![json["status"]],
        ca: json["ca"],
        exam: json["exam"],
        total: json["total"],
        grade: json["grade"],
      );

  Map<String, dynamic> toJson() => {
        "semester": semesterValues.reverse[semester],
        "code": code,
        "title": title,
        "unit": unit,
        "status": statusValues.reverse[status],
        "ca": ca,
        "exam": exam,
        "total": total,
        "grade": grade,
      };
}

enum Semester { THE_20192020_HARMATTAN_SEMESTER, THE_20192020_RAIN_SEMESTER }

final semesterValues = EnumValues({
  "2019/2020 Harmattan Semester": Semester.THE_20192020_HARMATTAN_SEMESTER,
  "2019/2020 Rain Semester": Semester.THE_20192020_RAIN_SEMESTER
});

enum Status { R, C }

final statusValues = EnumValues({"C": Status.C, "R": Status.R});

class EnumValues<T> {
  Map<String, T>? map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
