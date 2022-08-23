class User {
  User({
      this.username,});

  User.fromJson(dynamic json) {
    username = json['username'];
  }
  String? username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    return map;
  }

}