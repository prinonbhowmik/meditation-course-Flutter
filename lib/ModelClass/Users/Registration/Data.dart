class Data {
  Data({
      this.message, 
      this.fullname, 
      this.username, 
      this.email, 
      this.otp, 
      this.createdOn,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    fullname = json['fullname'];
    username = json['username'];
    email = json['email'];
    otp = json['otp'];
    createdOn = json['createdOn'];
  }
  String? message;
  String? fullname;
  String? username;
  String? email;
  String? otp;
  String? createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['fullname'] = fullname;
    map['username'] = username;
    map['email'] = email;
    map['otp'] = otp;
    map['createdOn'] = createdOn;
    return map;
  }

}