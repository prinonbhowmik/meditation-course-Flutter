import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:meditation_course/ApiHelper/base_url.dart';
import 'package:meditation_course/Class/new_password.dart';
import 'package:meditation_course/ModelClass/Users/ForgetPassword/Forget_password.dart';
import 'package:meditation_course/ModelClass/Users/RequestPassword/Request_pass.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerEmail = TextEditingController();
    final TextEditingController _controllerOtp = TextEditingController();
    bool _isVisible = true;
    String email,otp;

    void showOtpLayout() {
      setState(() {
        _isVisible = !_isVisible;
      });
    }

    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _controllerEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: (MediaQuery.of(context).size.width) * 0.10,
                child: ElevatedButton(
                  onPressed: () async {
                    email = _controllerEmail.text.toString();
                    if(email != null || !email.isEmpty){
                      
                      final response = await http.post(Uri.parse(BaseUrl+"forget-password"),
                          body:{
                            "email": _controllerEmail.text.toString()
                          });

                      var responseBody = ForgetPassword.fromJson(json.decode(response.body));

                      if (response.statusCode == 200){
                        print("KiMSg : "+responseBody.result!.status.toString());
                        if(responseBody.result!.status == 202){
                          var mesg = responseBody.data!.message;
                          Fluttertoast.showToast(msg: '$mesg');
                        }else{
                          var errorMsg = responseBody.result!.errorMsg;
                          Fluttertoast.showToast(msg: '$errorMsg');
                        }
                      }else{
                        Fluttertoast.showToast(msg: "Invalid Request");
                      }
                    }
                  },
                  child: Text('Check Email'),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _controllerOtp,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Otp',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: (MediaQuery.of(context).size.width) * 0.10,
                child: ElevatedButton(
                  onPressed: () async {
                    otp = _controllerOtp.text.toString();

                    if(otp != null || otp.isNotEmpty) {

                      final response = await http.post(Uri.parse(
                          BaseUrl + "request-password"),
                          body: {
                            "email": _controllerEmail.text.toString(),
                            "otp": otp
                          });

                      var respondBody = RequestPass.fromJson(json.decode(response.body));

                      if(response.statusCode == 200){
                        if(respondBody.result!.status == 202){
                          var mesg = respondBody.data!.message;
                          Fluttertoast.showToast(msg: '$mesg');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewPassword(otp: otp,email: _controllerEmail.text.toString(),)
                              )
                          );
                        }else{
                          var errorMsg = respondBody.result!.errorMsg;
                          Fluttertoast.showToast(msg: '$errorMsg');
                        }
                      }else{
                        Fluttertoast.showToast(msg: 'Invalid Request');
                      }
                    }


                  },
                  child: Text('Verify'),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
