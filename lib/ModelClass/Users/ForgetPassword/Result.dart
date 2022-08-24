class Result {
  Result({
      this.isError, 
      this.status, 
      this.errorMsg,});

  Result.fromJson(dynamic json) {
    isError = json['isError'];
    status = json['status'];
    errorMsg = json['errorMsg'];
  }
  bool? isError;
  int? status;
  String? errorMsg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isError'] = isError;
    map['status'] = status;
    map['errorMsg'] = errorMsg;
    return map;
  }

}