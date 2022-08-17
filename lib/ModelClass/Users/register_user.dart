import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    required this.fullname,
    required this.username,
    required this.email,
    required this.password,
    required this.otp,
    required this.active,
    required this.id,
    required this.creationDate,
    required this.v,
    required this.message,
  });

  String fullname;
  String username;
  String email;
  String password;
  String otp;
  bool active;
  String id;
  DateTime creationDate;
  int v;
  String message;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    fullname: json["fullname"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    otp: json["otp"],
    active: json["active"],
    id: json["_id"],
    creationDate: DateTime.parse(json["creation_date"]),
    v: json["__v"],
    message: json["message"] ??"",
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "username": username,
    "email": email,
    "password": password,
    "otp": otp,
    "active": active,
    "_id": id,
    "creation_date": creationDate.toIso8601String(),
    "__v": v,
    "message": message,
  };
}
