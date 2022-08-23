import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditation_course/Class/courses.dart';
import 'package:meditation_course/Class/registration.dart';
import 'package:meditation_course/ModelClass/Users/Login/UserBaseResponse.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  var loggedIn = false;
  var base_url = "http://192.168.68.101:8081/api/";
  final String applicat = 'application';
  final String authpassword = 'secret';
  String basicAuth =
      'Basic ${base64.encode(utf8.encode('aplication:password'))}';

  bool _isObscure = true;

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
            )),
        body: Column(
          children: [
            Expanded(
                flex: 8,
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.ac_unit_sharp,
                        size: 35,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: TextField(
                          controller: _controllerEmail,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter username"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: TextFormField(
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
                              final String applicat = 'application';
                              final String authpassword = 'secret';
                              String basicAuth =
                                  'Basic ${base64.encode(utf8.encode('$applicat:$authpassword'))}';
                              final response = await http.post(Uri.parse("http://192.168.68.103/api/oauth/token"),
                                  headers: {'authorization': basicAuth},
                              body: {
                                'grant_type':'password',
                                'username':_controllerEmail.text.toString(),
                                'password':_controllerPass.text.toString()
                              });

                              print("checkCode : "+response.body);
                              print("checkCode : "+response.statusCode.toString());

                              if(response.statusCode == 200){
                                Fluttertoast.showToast(msg: "Login successful!");
                                try{
                                  //String responseBody = utf8.decoder.convert(response.body);
                                  var responseData = UserBaseResponse.fromJson(json.decode(response.body));
                                  String? token = responseData.data?.accessToken.toString();
                                  print("CheckToken :  $token");
                                }catch(e){
                                  print('CheckError : '+e.toString());
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Courses()));
                              }else{
                                Fluttertoast.showToast(msg: 'Invalid credential');
                              }

                            },
                            child: Text('Login'),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.blue),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Forgot Password',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Registration()
                                    )
                                );
                              },
                              child: Text(
                                "Don't have an account? Sign Up",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset("images/google.png"),
                            onPressed: () {
                              Fluttertoast.showToast(msg: 'Google clicked');
                            },
                          ),
                          IconButton(
                            icon: Image.asset("images/facebook.png"),
                            onPressed: () {
                              Fluttertoast.showToast(msg: 'Facebook clicked');
                            },
                          ),
                        ],
                      ),
                      Text(
                        'Or sign in with social accounts',
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
      ),
    );

  }
}
