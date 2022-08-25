import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditation_course/ApiHelper/api_list.dart';
import 'package:meditation_course/ApiHelper/base_url.dart';
import 'package:meditation_course/Class/courses.dart';
import 'package:meditation_course/Class/login.dart';
import 'package:meditation_course/Class/otp_verify.dart';
import 'package:meditation_course/ModelClass/Users/Registration/Register_user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerfullname = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  final TextEditingController _controllerConfirmPass = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isObscure2 = true;

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
      key: _formKey,
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
        body: ListView(
          children: [
            Expanded(
                flex: 8,
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.ac_unit_sharp,
                        size: 35,
                      ),
                      const Text(
                        'Register',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          /*validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter full name';
                            }
                            return null;
                          },*/
                          controller: _controllerfullname,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              //errorText: "Field can't be empty!",
                              labelText: "Full name *"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          /*validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },*/
                          controller: _controllerUser,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              //errorText: "Field can't be empty!",
                              labelText: "User name *"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          /*validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },*/
                          controller: _controllerEmail,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              //errorText: "Field can't be empty!",
                              labelText: "Enter Email Address",
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          /*validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },*/
                          controller: _controllerPass,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
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
                            //errorText: "Field can't be empty!",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          /*validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },*/
                          controller: _controllerConfirmPass,
                          obscureText: _isObscure2,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirm Password',
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
                            //errorText: "Field can't be empty!",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          height: (MediaQuery.of(context).size.width) * 0.10,
                          child: ElevatedButton(
                            onPressed: () async {
                              if(_controllerfullname.text.toString() == null || _controllerfullname.text.toString().isEmpty){
                                Fluttertoast.showToast(msg: 'Enter fullname');
                              }else if(_controllerUser.text.toString() == null || _controllerUser.text.toString().isEmpty){
                                Fluttertoast.showToast(msg: 'Enter username');
                              }else if(_controllerEmail.text.toString() == null || _controllerEmail.text.toString().isEmpty
                                  || !_controllerEmail.text.toString().contains("@") || !_controllerEmail.text.toString().contains(".")){
                                Fluttertoast.showToast(msg: 'Enter valid email address');
                              }else if(_controllerPass.text.toString() == null || _controllerPass.text.toString().isEmpty){
                                Fluttertoast.showToast(msg: 'Enter password');
                              }else if(_controllerConfirmPass.text.toString() == null || _controllerConfirmPass.text.toString().isEmpty){
                                Fluttertoast.showToast(msg: 'Enter confirm password');
                              } else{
                                if  (_controllerConfirmPass.text.toString()==_controllerPass.text.toString()){
                                  var response = await http.post(
                                      Uri.parse(BaseUrl+"signup"),
                                      body: {
                                        "fullname":
                                        _controllerfullname.text.toString(),
                                        "username":
                                        _controllerUser.text.toString(),
                                        "email":
                                        _controllerEmail.text.toString(),
                                        "password":
                                        _controllerConfirmPass.text.toString()
                                      });

                                  var responseData = RegisterUser.fromJson(json.decode(response.body));

                                  print("ResponseCode : "+response.statusCode.toString());

                                  if (response.statusCode == 200) {
                                    Fluttertoast.showToast(msg: "Registration successful!");

                                    String? otp = responseData.data!.otp;

                                    print("Registration data: "+responseData.data!.otp.toString() +" , "
                                        +responseData.data!.email.toString());

                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(
                                            builder: (context) => Otp_Verify(
                                              otp: otp.toString(),
                                              email:
                                              responseData.data!.email.toString(),
                                            )
                                        ),
                                            (route) => false
                                    );

                                  } else {
                                    var errorMsg = responseData.result!.errorMsg;
                                    Fluttertoast.showToast(msg: 'Invalid credential');
                                  }
                                }
                                else{
                                  Fluttertoast.showToast(msg: "Password doesn't matched!");
                                }
                              }

                            },
                            child: Text('Register'),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.blue),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: const Text(
                                "Already have an account? Login here",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Copyright © '),
                      InkWell(
                        onTap: () async {
                          final Uri url =
                              Uri.parse("https://www.techanalyticaltd.com/");
                          _launchUrl(url);
                        },
                        child: const Text('Tech Analytica Limited ',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            )),
                      ),
                      Text('2022'),
                    ],
                  ),
                )),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    ));
  }
}
