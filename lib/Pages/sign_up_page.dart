import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:iddevice/Services/service_of_navigator.dart';

class SignUpPage extends StatefulWidget {
  final String baseUrl;

  SignUpPage({required this.baseUrl});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _student_idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _academic_yearController = TextEditingController();

  String _deviceID = '';
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _getDeviceID();
  }

  Future<void> _getDeviceID() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    setState(() {
      _deviceID = androidInfo.id;
    });
  }

  Future<void> _signUp() async {
    final username = _usernameController.text;
    final student_id = _student_idController.text;
    final email = _emailController.text;
    final academic_year = _academic_yearController.text;

    // Split username by spaces to check the number of parts
    final nameParts = username.split(' ');

    if (nameParts.length != 2) {
      _showErrorMessage('You should enter first and last name only');
      return;
    }

    if (username.isNotEmpty &&
        student_id.isNotEmpty &&
        email.isNotEmpty &&
        academic_year.isNotEmpty) {
      final response = await http.post(
        Uri.parse('${widget.baseUrl}/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'student_id': student_id,
          'device_id': _deviceID,
          'email': email,
          'academic_year': academic_year,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MainApp(baseUrl: widget.baseUrl, device_id: _deviceID),
          ),
        );
      } else if (response.statusCode == 409) {
        _showErrorMessage('Username already exists');
      } else {
        _showErrorMessage('Failed to sign up');
      }
    } else {
      _showErrorMessage('Please fill out all fields');
    }
  }

  void _showErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _errorMessage = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width,
                    child: FadeInUp(
                        duration: Duration(seconds: 1),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background3.png'),
                                  fit: BoxFit.fill)),
                        )),
                  ),
                  Positioned(
                    height: 400,
                    width: width + 20,
                    child: FadeInUp(
                        duration: Duration(milliseconds: 1000),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background-2.png'),
                                  fit: BoxFit.fill)),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontFamily: "Schyler",
                            color: Color(0xFF277867),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: Color(0xFF277867)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF277867),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFF277867)))),
                              child: TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "First and Last Name",
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontFamily: "Schyler",
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFF277867)))),
                              child: TextField(
                                controller: _student_idController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "ID",
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontFamily: "Schyler",
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFF277867)))),
                              child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontFamily: "Schyler",
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: _academic_yearController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Academic Year",
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontFamily: "Schyler",
                                    )),
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1900),
                      child: MaterialButton(
                        onPressed: _signUp,
                        color: Color(0xFF277867),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 50,
                        child: Center(
                          child: Text(
                            
                            "Sign Up",
                            style: TextStyle(color: Colors.white, fontFamily: "Schyler"),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  if (_errorMessage != null)
                    Container(
                      padding: EdgeInsets.all(16.0),
                      color: Color(0xFF002C31),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Schyler"),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
