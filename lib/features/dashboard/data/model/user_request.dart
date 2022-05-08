import 'dart:convert';

class Data {
    Data({
        this.user,
    });

    User? user;

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
    };
}

class User {
  User({
    this.avatar,
    this.signature,
    this.matricNumber,
    this.fullName,
    this.session,
    this.faculty,
    this.department,
    this.course,
    this.level,
    this.gender,
    this.address,
    this.studentEmail,
    this.phoneNumber,
    this.modeOfEntry,
    this.studentShipStatus,
    this.chargesPaid,
    this.dateOfBirth,
    this.stateOfOrigin,
    this.lgaOfOrigin,
    this.levelAdviser,
    this.nextOfKin,
    this.guardian,
    this.sponsor,
    this.semester,
  });

  String? avatar;
  String? signature;
  String? matricNumber;
  String? fullName;
  String? session;
  String? faculty;
  String? department;
  String? course;
  String? level;
  String? gender;
  String? address;
  String? studentEmail;
  String? phoneNumber;
  String? modeOfEntry;
  String? studentShipStatus;
  String? chargesPaid;
  String? dateOfBirth;
  String? stateOfOrigin;
  String? lgaOfOrigin;
  LevelAdviser? levelAdviser;
  NextOfKin? nextOfKin;
  Guardian? guardian;
  Guardian? sponsor;
  Semester? semester;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
        levelAdviser: LevelAdviser.fromJson(
            json["levelAdviser"] ?? Map<String, dynamic>()),
        nextOfKin:
            NextOfKin.fromJson(json["nextOfKin"] ?? Map<String, dynamic>()),
        guardian: Guardian.fromJson(json["guardian"] ?? Map<String, dynamic>()),
        sponsor: Guardian.fromJson(json["sponsor"] ?? Map<String, dynamic>()),
        semester: Semester.fromJson(json["semester"] ?? Map<String, dynamic>()),
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
        "levelAdviser": levelAdviser!.toJson(),
        "nextOfKin": nextOfKin!.toJson(),
        "guardian": guardian!.toJson(),
        "sponsor": sponsor!.toJson(),
        "semester": semester!.toJson(),
      };
}

class Guardian {
  Guardian({
    this.name,
    this.address,
    this.phoneNumber,
    this.email,
    this.fullName,
  });

  String? name;
  String? address;
  String? phoneNumber;
  String? email;
  String? fullName;

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

class NextOfKin {
  NextOfKin({
    this.fullName,
    this.address,
    this.relationship,
    this.phoneNumber,
    this.email,
  });

  String? fullName;
  String? address;
  String? relationship;
  String? phoneNumber;
  String? email;

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
    this.type,
    this.number,
    this.year,
  });

  String? type;
  String? number;
  String? year;

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
