class RegisterUser {
  RegisterUser({
      this.fullname, 
      this.username, 
      this.email, 
      this.password, 
      this.otp, 
      this.active, 
      this.id, 
      this.creationDate, 
      this.v,});

  RegisterUser.fromJson(dynamic json) {
    fullname = json['fullname'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
    active = json['active'];
    id = json['_id'];
    creationDate = json['creation_date'];
    v = json['__v'];
  }
  String? fullname;
  String? username;
  String? email;
  String? password;
  String? otp;
  bool? active;
  String? id;
  String? creationDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullname'] = fullname;
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    map['otp'] = otp;
    map['active'] = active;
    map['_id'] = id;
    map['creation_date'] = creationDate;
    map['__v'] = v;
    return map;
  }

}