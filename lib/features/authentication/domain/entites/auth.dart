import 'package:equatable/equatable.dart';
import 'dart:convert';

class Authentication extends Equatable {
  Authentication({
    required this.success,
    required this.message,
    required this.data,
    required this.token,
  });

 final bool success;
 final String message;
 final Data data;
 final String token;

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        token: json["token"],
      );

  @override
  List<Object?> get props => [success, message, data, token];
}

class Data {
  Data({
    required this.user,
  });

  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
      );
}

class User {
  User({
    required this.avatar,
    required this.signature,
    required this.matricNumber,
    required this.fullName,
    required this.session,
    required this.faculty,
    required this.department,
    required this.course,
    required this.level,
    required this.gender,
    required this.address,
    required this.studentEmail,
    required this.phoneNumber,
    required this.modeOfEntry,
    required this.studentShipStatus,
    required this.chargesPaid,
    required this.dateOfBirth,
    required this.stateOfOrigin,
    required this.lgaOfOrigin,
    required this.levelAdviser,
    required this.nextOfKin,
    required this.guardian,
    required this.sponsor,
    required this.semester,
  });

  String avatar;
  String signature;
  String matricNumber;
  String fullName;
  String session;
  String faculty;
  String department;
  String course;
  String level;
  String gender;
  String address;
  String studentEmail;
  String phoneNumber;
  String modeOfEntry;
  String studentShipStatus;
  String chargesPaid;
  String dateOfBirth;
  String stateOfOrigin;
  String lgaOfOrigin;
  LevelAdviser levelAdviser;
  NextOfKin nextOfKin;
  Guardian guardian;
  Guardian sponsor;
  Semester semester;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json["avatar"],
        signature: json["signature"],
        matricNumber: json["matricNumber"],
        fullName: json["fullName"],
        session: json["session"],
        faculty: json["faculty"],
        department: json["department"],
        course: json["course"],
        level: json["level"],
        gender: json["gender"],
        address: json["address"],
        studentEmail: json["studentEmail"],
        phoneNumber: json["phoneNumber"],
        modeOfEntry: json["modeOfEntry"],
        studentShipStatus: json["studentShipStatus"],
        chargesPaid: json["chargesPaid"],
        dateOfBirth: json["dateOfBirth"],
        stateOfOrigin: json["stateOfOrigin"],
        lgaOfOrigin: json["lgaOfOrigin"],
        levelAdviser: LevelAdviser.fromJson(json["levelAdviser"]),
        nextOfKin: NextOfKin.fromJson(json["nextOfKin"]),
        guardian: Guardian.fromJson(json["guardian"]),
        sponsor: Guardian.fromJson(json["sponsor"]),
        semester: Semester.fromJson(json["semester"]),
      );
}

class Guardian {
  Guardian({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.fullName,
  });

  String name;
  String address;
  String phoneNumber;
  String email;
  String fullName;

  factory Guardian.fromRawJson(String str) =>
      Guardian.fromJson(json.decode(str));

  factory Guardian.fromJson(Map<String, dynamic> json) => Guardian(
        name: json["name"] == null ? null : json["name"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        fullName: json["fullName"] == null ? null : json["fullName"],
      );
}

class LevelAdviser {
  LevelAdviser({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });

  String fullName;
  String email;
  String phoneNumber;

  factory LevelAdviser.fromRawJson(String str) =>
      LevelAdviser.fromJson(json.decode(str));

  factory LevelAdviser.fromJson(Map<String, dynamic> json) => LevelAdviser(
        fullName: json["fullName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
      );
}

class NextOfKin {
  NextOfKin({
    required this.fullName,
    required this.address,
    required this.relationship,
    required this.phoneNumber,
    required this.email,
  });

  String fullName;
  String address;
  String relationship;
  String phoneNumber;
  String email;

  factory NextOfKin.fromRawJson(String str) =>
      NextOfKin.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NextOfKin.fromJson(Map<String, dynamic> json) => NextOfKin(
        fullName: json["fullName"],
        address: json["address"],
        relationship: json["relationship"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "address": address,
        "relationship": relationship,
        "phoneNumber": phoneNumber,
        "email": email,
      };
}

class Semester {
  Semester({
    required this.type,
    required this.number,
    required this.year,
  });

  String type;
  String number;
  String year;

  factory Semester.fromJson(Map<String, dynamic> json) => Semester(
        type: json["type"],
        number: json["number"],
        year: json["year"],
      );
}
