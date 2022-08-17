import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  final TextEditingController _controllerSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: _controllerSearch,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Search",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
              child: Text(
                'Courses',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
              child: Card(
                elevation: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/course.png',
                    ),
                    Text(
                      ' Course name',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      ' 10000',
                      style: TextStyle(color: Colors.black45),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      ' COURSE DETAILS',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
              child: Card(
                elevation: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/course.png',
                    ),
                    Text(
                      ' Course name',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      ' 10000',
                      style: TextStyle(color: Colors.black45),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      ' COURSE DETAILS',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
              child: Card(
                elevation: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/course.png',
                    ),
                    Text(
                      ' Course name',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      ' 10000',
                      style: TextStyle(color: Colors.black45),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      ' COURSE DETAILS',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
