import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditation_course/ApiHelper/api_list.dart';
import 'package:meditation_course/Class/courses.dart';
import 'package:meditation_course/Class/registration.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();

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
                        child: TextField(
                          controller: _controllerPass,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          height: (MediaQuery.of(context).size.width) * 0.10,
                          child: ElevatedButton(
                            onPressed: () {

                              Login? _login = ApiHelper().loginUser("password", _controllerEmail.text.toString(), _controllerPass.text.toString());

                              print("CheckErrorData : "+_login.toString());

                              if(_login != null){
                                print(_login);
                                print("login successful");
                                Fluttertoast.showToast(msg: "Login successful!");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Courses()
                                    )
                                );
                              }else{
                                Fluttertoast.showToast(msg: "Incorrect input!");
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
