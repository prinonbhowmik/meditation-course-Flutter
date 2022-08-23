import 'Data.dart';
import 'Result.dart';

class UserBaseResponse {
  UserBaseResponse({
      this.data, 
      this.result,});

  UserBaseResponse.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  Data? data;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}