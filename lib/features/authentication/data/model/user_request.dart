import 'dart:convert';

class UserRequest {
  UserRequest({
    required this.user,
    required this.token,
  });

  final DataUser user;
  final String token;

  factory UserRequest.fromRawJson(String str) =>
      UserRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
        user: DataUser.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class DataUser {
  DataUser({
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
    required this.user,
  });

  final String avatar;
  final String signature;
  final String matricNumber;
  final String fullName;
  final String session;
  final String faculty;
  final String department;
  final String course;
  final String level;
  final String gender;
  final String address;
  final String studentEmail;
  final String phoneNumber;
  final String modeOfEntry;
  final String studentShipStatus;
  final String chargesPaid;
  final String dateOfBirth;
  final String stateOfOrigin;
  final String lgaOfOrigin;
  final LevelAdviser levelAdviser;
  final NextOfKin nextOfKin;
  final Guardian guardian;
  final Guardian sponsor;
  final Semester semester;
  final UserUser user;

  factory DataUser.fromRawJson(String str) =>
      DataUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
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
        user: UserUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "signature": signature,
        "matricNumber": matricNumber,
        "fullName": fullName,
        "session": session,
        "faculty": faculty,
        "department": department,
        "course": course,
        "level": level,
        "gender": gender,
        "address": address,
        "studentEmail": studentEmail,
        "phoneNumber": phoneNumber,
        "modeOfEntry": modeOfEntry,
        "studentShipStatus": studentShipStatus,
        "chargesPaid": chargesPaid,
        "dateOfBirth": dateOfBirth,
        "stateOfOrigin": stateOfOrigin,
        "lgaOfOrigin": lgaOfOrigin,
        "levelAdviser": levelAdviser.toJson(),
        "nextOfKin": nextOfKin.toJson(),
        "guardian": guardian.toJson(),
        "sponsor": sponsor.toJson(),
        "semester": semester.toJson(),
        "user": user.toJson(),
      };
}

class Guardian {
  Guardian({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.fullName,
  });

  final String name;
  final String address;
  final String phoneNumber;
  final String email;
  final String fullName;

  factory Guardian.fromRawJson(String str) =>
      Guardian.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Guardian.fromJson(Map<String, dynamic> json) => Guardian(
        name: json["name"] == null ? null : json["name"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        fullName: json["fullName"] == null ? null : json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "address": address,
        "phoneNumber": phoneNumber,
        "email": email,
        "fullName": fullName == null ? null : fullName,
      };
}

class LevelAdviser {
  LevelAdviser({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });

  final String fullName;
  final String email;
  final String phoneNumber;

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

class NextOfKin {
  NextOfKin({
    required this.fullName,
    required this.address,
    required this.relationship,
    required this.phoneNumber,
    required this.email,
  });

  final String fullName;
  final String address;
  final String relationship;
  final String phoneNumber;
  final String email;

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

  final String type;
  final String number;
  final String year;

  factory Semester.fromRawJson(String str) =>
      Semester.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Semester.fromJson(Map<String, dynamic> json) => Semester(
        type: json["type"],
        number: json["number"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "number": number,
        "year": year,
      };
}

class UserUser {
  UserUser({
    required this.id,
    required this.fullName,
    required this.avatar,
    required this.faculty,
    required this.department,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.role,
  });

  final String id;
  final String fullName;
  final String avatar;
  final String faculty;
  final String department;
  final String level;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String role;

  factory UserUser.fromRawJson(String str) =>
      UserUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserUser.fromJson(Map<String, dynamic> json) => UserUser(
        id: json["_id"],
        fullName: json["fullName"],
        avatar: json["avatar"],
        faculty: json["faculty"],
        department: json["department"],
        level: json["level"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "avatar": avatar,
        "faculty": faculty,
        "department": department,
        "level": level,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "role": role,
      };
}
