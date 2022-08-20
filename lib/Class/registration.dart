import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditation_course/ApiHelper/api_list.dart';
import 'package:meditation_course/Class/login.dart';
import 'package:meditation_course/Class/otp_verify.dart';
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

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }


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
          )
      ),
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
                      child: TextField(
                        controller: _controllerfullname,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            errorText: "Field can't be empty!",
                            labelText: "Full name *"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _controllerUser,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            errorText: "Field can't be empty!",
                            labelText: "User name *"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _controllerEmail,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            errorText: "Field can't be empty!",
                            labelText: "Enter Email Address"),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _controllerPass,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          errorText: "Field can't be empty!",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _controllerConfirmPass,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                          errorText: "Field can't be empty!",
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
                            if (_controllerfullname.text.toString() != null ||
                                _controllerUser.text.toString() != null ||
                                _controllerEmail.text.toString() != null ||
                            _controllerPass.text.toString() != null ||
                            _controllerConfirmPass.text.toString() != null) {
                              if (_controllerPass.text.toString() ==
                                  _controllerConfirmPass.text.toString()) {
                                var _register = ApiHelper().registerUser(
                                    _controllerfullname.text.toString(),
                                    _controllerUser.text.toString(),
                                    _controllerEmail.text.toString(),
                                    _controllerConfirmPass.text.toString());

                                if(_register !=null){
                                  print(_register);

                                  Fluttertoast.showToast(msg: "Registration successful!");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Otp_Verify()));
                                }else{
                                  Fluttertoast.showToast(msg: "Input is not valid");
                                }

                              } else {

                              }
                            }


                            setState(() {

                            });
                          },
                          child: Text('Register'),
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
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
              )
          ),
          Expanded(
              flex: 1,
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Copyright © '),
                    InkWell(
                      onTap: () async{
                        final Uri url = Uri.parse("https://www.techanalyticaltd.com/");
                        _launchUrl(url);
                      },
                      child: const Text('Tech Analytica Limited ',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          )
                      ),
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
    ));
  }
}
