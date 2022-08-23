import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:meditation_course/Class/courses.dart';
import 'package:meditation_course/ModelClass/Users/Registration/Otp_Verify.dart';
import 'package:meditation_course/ModelClass/Users/Registration/Register_user.dart';


class Otp_Verify extends StatefulWidget {
  final String email;
  final String otp;

  const Otp_Verify({Key? key,required this.email,required this.otp}) : super(key: key);

  @override
  State<Otp_Verify> createState() => _Otp_VerifyState();
}

class _Otp_VerifyState extends State<Otp_Verify> {

  final TextEditingController _controllerOtp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              backgroundColor: Colors.blue,
              leading: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              title: Row(
                children: const [
                  Icon(Icons.account_balance),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Logo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'RobotoMono'),
                  ),
                ],
              )),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _controllerOtp,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Otp',
                      errorText: "Field can't be empty!",

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    height: (MediaQuery.of(context).size.width) * 0.10,
                    child: ElevatedButton(
                      onPressed: () async {
                        print("CheckPassData :  "+widget.email+" "+widget.otp);

                        if(_controllerOtp.text.toString() == widget.otp){
                          final response = await http.post(Uri.parse("http://192.168.68.103/api/verify"),
                              body: {
                                'email':widget.email,
                                'password':_controllerOtp.text.toString()
                              });

                          var responseBody = OtpVerify.fromJson(json.decode(response.body));

                          if(response.statusCode == 200){
                            Fluttertoast.showToast(msg: widget.email+" is active now!");
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Courses()
                                ),
                                    (route) => false
                            );

                          }else{
                            Fluttertoast.showToast(msg: "Otp doesn't matched");
                          }
                        }else{
                          Fluttertoast.showToast(msg: "Otp doesn't matched");
                        }
                      },
                      child: Text('Verify'),
                      style:
                      ElevatedButton.styleFrom(primary: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
