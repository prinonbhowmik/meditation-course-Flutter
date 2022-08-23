import 'User.dart';

class Data {
  Data({
      this.accessToken, 
      this.accessTokenExpiresAt, 
      this.refreshToken, 
      this.refreshTokenExpiresAt, 
      this.user,});

  Data.fromJson(dynamic json) {
    accessToken = json['access_token'];
    accessTokenExpiresAt = json['accessTokenExpiresAt'];
    refreshToken = json['refresh_token'];
    refreshTokenExpiresAt = json['refreshTokenExpiresAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? accessToken;
  String? accessTokenExpiresAt;
  String? refreshToken;
  String? refreshTokenExpiresAt;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['accessTokenExpiresAt'] = accessTokenExpiresAt;
    map['refresh_token'] = refreshToken;
    map['refreshTokenExpiresAt'] = refreshTokenExpiresAt;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}