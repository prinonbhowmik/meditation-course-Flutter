import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:meditation_course/ApiHelper/base_url.dart';
import 'package:meditation_course/Class/courses.dart';
import 'package:meditation_course/ModelClass/Users/Registration/OtpVerify/OtpVerify.dart';

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


                        if(_controllerOtp.text.toString() == widget.otp.toString()){
                          final response = await http.post(Uri.parse(BaseUrl+"verify"),
                              body: {
                                'email':widget.email.toString(),
                                'otp':_controllerOtp.text.toString()
                              });

                          var responseBody = OtpVerify.fromJson(json.decode(response.body));
                          print("CheckCode: "+response.statusCode.toString());
                          print("CheckPassData :  "+widget.email+" "+widget.otp);
                          if(response.statusCode == 200){
                            if (responseBody.result!.status==202){
                              print(responseBody.data);
                              Fluttertoast.showToast(msg: widget.email+" is active now!");
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Courses()
                                  ),
                                      (route) => false
                              );
                            }else{
                              var errorMsg = responseBody.result!.errorMsg;
                              Fluttertoast.showToast(msg: '$errorMsg');
                            }

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
