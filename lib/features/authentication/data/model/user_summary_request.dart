import 'dart:convert';

class UserSummaryRequest {
  UserSummaryRequest({
    this.user,
    this.token,
  });

  UserSummary? user;
  String? token;

  factory UserSummaryRequest.fromRawJson(String str) =>
      UserSummaryRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSummaryRequest.fromJson(Map<String, dynamic> json) =>
      UserSummaryRequest(
        user: UserSummary.fromJson(json["user"] ?? Map<String, dynamic>()),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "token": token,
      };
}

class UserSummary {
  UserSummary({
    this.avatar,
    this.matricNumber,
    this.fullName,
    this.faculty,
    this.department,
    this.course,
    this.level,
    this.levelAdviser,
    this.semester,
  });

  String? avatar;
  String? matricNumber;
  String? fullName;
  String? signature;
  String? faculty;
  String? department;
  String? course;
  String? level;
  LevelAdviser? levelAdviser;
  Semester? semester;

  factory UserSummary.fromRawJson(String str) =>
      UserSummary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSummary.fromJson(Map<String, dynamic> json) => UserSummary(
        avatar: json["avatar"],
        matricNumber: json["matricNumber"],
        fullName: json["fullName"],
        faculty: json["faculty"],
        department: json["department"],
        course: json["course"],
        level: json["level"],
        levelAdviser: LevelAdviser.fromJson(
          json["levelAdviser"] ?? Map<String, dynamic>(),
        ),
        semester: Semester.fromJson(json["semester"] ?? Map<String, dynamic>()),
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "signature": signature,
        "matricNumber": matricNumber,
        "fullName": fullName,
        "faculty": faculty,
        "department": department,
        "course": course,
        "level": level,
        "levelAdviser": levelAdviser!.toJson(),
        "semester": semester!.toJson(),
      };
}

class LevelAdviser {
  LevelAdviser({
    this.fullName,
    this.email,
    this.phoneNumber,
  });

  String? fullName;
  String? email;
  String? phoneNumber;

  factory LevelAdviser.fromRawJson(String str) =>
      LevelAdviser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LevelAdviser.fromJson(Map<String, dynamic> json) => LevelAdviser(
        fullName: json["fullName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}

class Semester {
  Semester({
    this.type,
    this.number,
    this.session,
  });

  String? type;
  String? number;
  String? session;

  factory Semester.fromRawJson(String str) =>
      Semester.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Semester.fromJson(Map<String, dynamic> json) => Semester(
        type: json["type"],
        number: json["number"],
        session: json["session"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "number": number,
        "session": session,
      };
}
