import 'dart:convert';

class SchedulesResponse {
    SchedulesResponse({
        this.success,
        this.message,
        this.data,
    });

    bool? success;
    String? message;
    Data? data;

    factory SchedulesResponse.fromRawJson(String str) => SchedulesResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SchedulesResponse.fromJson(Map<String, dynamic> json) => SchedulesResponse(
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
        this.schedules,
    });

    List<Schedule>? schedules;

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        schedules: List<Schedule>.from(json["schedules"].map((x) => Schedule.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "schedules": List<dynamic>.from(schedules!.map((x) => x.toJson())),
    };
}

class Schedule {
    Schedule({
        this.weekdays,
        this.id,
        this.user,
        this.courseCode,
        this.courseTitle,
        this.venue,
        this.startTime,
        this.endTime,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    List<String>? weekdays;
    String? id;
    String? user;
    String? courseCode;
    String? courseTitle;
    String? venue;
    DateTime? startTime;
    DateTime? endTime;
    String? note;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    factory Schedule.fromRawJson(String str) => Schedule.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        weekdays: List<String>.from(json["weekdays"].map((x) => x)),
        id: json["_id"],
        user: json["user"],
        courseCode: json["courseCode"],
        courseTitle: json["courseTitle"],
        venue: json["venue"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        note: json["note"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "weekdays": List<dynamic>.from(weekdays!.map((x) => x)),
        "_id": id,
        "user": user,
        "courseCode": courseCode,
        "courseTitle": courseTitle,
        "venue": venue,
        "startTime": startTime!.toIso8601String(),
        "endTime": endTime!.toIso8601String(),
        "note": note,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}
