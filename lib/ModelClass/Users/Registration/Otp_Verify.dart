import 'Result.dart';

class OtpVerify {
  OtpVerify({
      this.data, 
      this.result,});

  OtpVerify.fromJson(dynamic json) {
    data = json['data'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? data;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    if (result != null) {
      map['result'] = result!.toJson();
    }
    return map;
  }

}