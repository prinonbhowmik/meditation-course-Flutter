import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.data,
    required this.result,
  });

  Data data;
  Result result;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    data: Data.fromJson(json["data"]),
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "result": result.toJson(),
  };
}

class Data {
  Data({
    required this.accessToken,
    required this.accessTokenExpiresAt,
    required this.refreshToken,
    required this.refreshTokenExpiresAt,
    required this.user,
  });

  String accessToken;
  DateTime accessTokenExpiresAt;
  String refreshToken;
  DateTime refreshTokenExpiresAt;
  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["access_token"],
    accessTokenExpiresAt: DateTime.parse(json["accessTokenExpiresAt"]),
    refreshToken: json["refresh_token"],
    refreshTokenExpiresAt: DateTime.parse(json["refreshTokenExpiresAt"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "accessTokenExpiresAt": accessTokenExpiresAt.toIso8601String(),
    "refresh_token": refreshToken,
    "refreshTokenExpiresAt": refreshTokenExpiresAt.toIso8601String(),
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.username,
  });

  String username;

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
  };
}

class Result {
  Result({
    required this.isError,
    required this.status,
    required this.errorMsg,
  });

  bool isError;
  int status;
  ErrorMsg errorMsg;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    isError: json["isError"],
    status: json["status"],
    errorMsg: ErrorMsg.fromJson(json["errorMsg"]),
  );

  Map<String, dynamic> toJson() => {
    "isError": isError,
    "status": status,
    "errorMsg": errorMsg.toJson(),
  };
}

class ErrorMsg {
  ErrorMsg({
    required this.statusCode,
    required this.status,
    required this.code,
    required this.message,
    required this.name,
  });

  int statusCode;
  int status;
  int code;
  String message;
  String name;

  factory ErrorMsg.fromJson(Map<String, dynamic> json) => ErrorMsg(
    statusCode: json["statusCode"],
    status: json["status"],
    code: json["code"],
    message: json["message"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "code": code,
    "message": message,
    "name": name,
  };
}
