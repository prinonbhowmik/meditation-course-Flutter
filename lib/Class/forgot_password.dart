import 'package:flutter/material.dart';
import 'package:meditation_course/Class/new_password.dart';

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

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
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
                  onPressed: () {
                    setState(() {
                    });
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewPassword()
                        )
                    );
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
