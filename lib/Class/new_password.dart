// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditation_course/ApiHelper/base_url.dart';
import 'package:meditation_course/Class/login.dart';
import 'package:http/http.dart' as http;
import 'package:meditation_course/ModelClass/Users/ResetPassword/Reset_pass.dart';

class NewPassword extends StatefulWidget {
  final String email;
  final String otp;
  
  const NewPassword({Key? key, required this.email,required this.otp}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final TextEditingController _controllerPass = TextEditingController();
  final TextEditingController _controllerNewPass = TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  Widget build(BuildContext context) {
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
                    controller: _controllerPass,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _controllerNewPass,
                    obscureText: _isObscure2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm New Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure2 ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure2 = !_isObscure2;
                          });
                        },
                      ),
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

                        if (_controllerPass.text.isNotEmpty &&
                            _controllerNewPass.text.toString().isNotEmpty &&
                            _controllerPass.text.toString() == _controllerNewPass.text.toString())
                        {
                          final response = await http.post(Uri.parse(BaseUrl+"reset-password"),
                              body: {
                                "email": widget.email,
                                "password": _controllerNewPass.text.toString(),
                                "otp": widget.otp
                              });

                          var respondBody = ResetPass.fromJson(json.decode(response.body));

                          if(response.statusCode==200){
                            if(respondBody.result!.status==202){
                              var mesg = respondBody.data!.message;
                              Fluttertoast.showToast(msg: '$mesg');
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()
                                  ),
                                      (route) => false
                              );
                            }else{
                              var errorMsg = respondBody.data!.message;
                              Fluttertoast.showToast(msg: '$errorMsg');
                            }
                          }else{
                            Fluttertoast.showToast(msg: 'Invalid Request');
                          }
                        }else{
                          Fluttertoast.showToast(msg: "Passwords doesn't match");
                        }

                      },
                      child: Text('Change Password'),
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
