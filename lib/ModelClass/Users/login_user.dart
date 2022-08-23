import 'dart:convert';

LoginUser loginUserFromJson(String str) => LoginUser.fromJson(json.decode(str));

String loginUserToJson(LoginUser data) => json.encode(data.toJson());

class LoginUser {
  LoginUser({
    this.data,
    this.result,
  });

  Data? data;
  Result? result;

  factory LoginUser.fromJson(dynamic json) => LoginUser(
    data: Data.fromJson(json["data"]),
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "result": result!.toJson(),
  };
}

class Data {
  Data({
    this.accessToken,
    this.accessTokenExpiresAt,
    this.refreshToken,
    this.refreshTokenExpiresAt,
    this.username,
    this.expiryTime,
  });

  String? accessToken;
  DateTime? accessTokenExpiresAt;
  String? refreshToken;
  DateTime? refreshTokenExpiresAt;
  String? username;
  String? expiryTime;

  factory Data.fromJson(dynamic json) => Data(
    accessToken: json["access_token"],
    accessTokenExpiresAt: DateTime.parse(json["accessTokenExpiresAt"]),
    refreshToken: json["refresh_token"],
    refreshTokenExpiresAt: DateTime.parse(json["refreshTokenExpiresAt"]),
    username: json["username"],
    expiryTime: json["expiryTime"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "accessTokenExpiresAt": accessTokenExpiresAt!.toIso8601String(),
    "refresh_token": refreshToken,
    "refreshTokenExpiresAt": refreshTokenExpiresAt!.toIso8601String(),
    "username": username,
    "expiryTime": expiryTime,
  };
}

class Result {
  Result({
    this.isError,
    this.status,
    this.errorMsg,
  });

  bool? isError;
  int? status;
  ErrorMsg? errorMsg;

  factory Result.fromJson(dynamic json) => Result(
    isError: json["isError"],
    status: json["status"],
    errorMsg: ErrorMsg.fromJson(json["errorMsg"]),
  );

  Map<String, dynamic> toJson() => {
    "isError": isError,
    "status": status,
    "errorMsg": errorMsg!.toJson(),
  };
}

class ErrorMsg {
  ErrorMsg({
    this.statusCode,
    this.status,
    this.code,
    this.message,
    this.name,
  });

  int? statusCode;
  int? status;
  int? code;
  String? message;
  String? name;

  factory ErrorMsg.fromJson(dynamic json) => ErrorMsg(
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
