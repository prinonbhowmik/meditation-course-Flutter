import 'dart:convert';

import 'package:meditation_course/ModelClass/Users/register_user.dart';
import 'package:http/http.dart' as http;

import '../ModelClass/Users/login_user.dart';

class ApiHelper {
  var base_url = "http://192.168.68.101:8081/api/";
  final String applicat = 'application';
  final String authpassword = 'secret';
  String basicAuth =
      'Basic ${base64.encode(utf8.encode('aplication:password'))}';

  Future<Register?> registerUser(String fullname, String username, String email, String password) async {
    var response = await http
        .post(Uri.parse(base_url+"signup"), body: {
      "fullname": fullname,
      "username": username,
      "email": email,
      "password": password
    });

    var data = response.body;
      print(data);
    //return Register.fromJson(jsonDecode(data));

    if (response.statusCode == 200) {
       print(response.statusCode);
       var responseBody = response.body;
      print("Response Body$responseBody");
      return registerFromJson(responseBody);
    } else {
       print(
          "Error$response");
      return null;
    }
  }

  /*Future<LoginUser?> loginUser(String grant_type,String username, String password) async {
    var response = await http.post(Uri.parse(base_url+"oauth/token"),
        headers: {'authorization': basicAuth},
        body: {
      "grant_type":grant_type,
      "username":username,
      "password":password
    });

    var data = response.body;

    print("CheckLogin : "+data);

    if (response.statusCode == 200){
      print(response.statusCode);
      var responseBody = response.body;
      print("Response Body $responseBody");
      return LoginUser.fromJson(responseBody);
    }else {
      print(
          "Error$response");
      return null;
    }
  }*/
}
