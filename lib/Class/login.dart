import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meditation_course/ApiHelper/base_url.dart';
import 'package:meditation_course/Class/courses.dart';
import 'package:meditation_course/Class/forgot_password.dart';
import 'package:meditation_course/Class/registration.dart';
import 'package:meditation_course/ModelClass/Users/Login/UserBaseResponse.dart';
import 'package:meditation_course/Utils/google_signin_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  var loggedIn = false;

  bool _isObscure = true;

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  Future<bool> validation () async {
    if(_controllerEmail.text.toString() == null || _controllerEmail.text.toString().isEmpty){
      Fluttertoast.showToast(msg: 'Enter username');
      return false;
    }else if(_controllerPass.text.toString() == null || _controllerPass.text.toString().isEmpty){
      Fluttertoast.showToast(msg: 'Enter password');
      return false;
    } else{
      return true;
    }
  }
  Future _signinGoogle() async {
    GoogleSignIn _googleSignin = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    try {
     var result = await _googleSignin.signIn();

      print("GoogleTerms : "+result.toString());
    } catch (error) {
      print("GoogleTerms : "+error.toString());
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
                      const Icon(
                        Icons.ac_unit_sharp,
                        size: 35,
                      ),
                      const Text(
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
                              if(validation() == true){
                                final String applicat = 'application';
                                final String authpassword = 'secret';
                                String basicAuth =
                                    'Basic ${base64.encode(utf8.encode('$applicat:$authpassword'))}';
                                final response = await http.post(Uri.parse(BaseUrl+"oauth/token"),
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
                                    var responseData = UserBaseResponse.fromJson(json.decode(response.body));
                                    String? token = responseData.data?.accessToken.toString();
                                    print("CheckToken :  $token");
                                  }catch(e){
                                    print('CheckError : '+e.toString());
                                  }
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                          builder: (context) => Courses()
                                      ),
                                          (route) => false
                                  );
                                }else{
                                  Fluttertoast.showToast(msg: 'Invalid credential');
                                }
                              }

                            },
                            child: Text('Login'),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.blue),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap:(){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ForgotPassword()
                                    )
                                );
                              },
                              child: const Text(
                                'Forgot Password',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Registration()
                                    )
                                );
                              },
                              child: const Text(
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
                            onPressed:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignInDemo()
                                  )
                              );
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
                      const Text(
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
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );

  }
}
