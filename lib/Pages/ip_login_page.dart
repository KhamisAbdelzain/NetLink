import 'dart:async';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'package:animate_do/animate_do.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:iddevice/Pages/sign_up_page.dart';

import 'package:iddevice/Services/service_of_navigator.dart';

class IpInputApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'User Auth App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: IpInputPage(),
        );
      },
    );
  }
}

class IpInputPage extends StatefulWidget {
  @override
  _IpInputPageState createState() => _IpInputPageState();
}

class _IpInputPageState extends State<IpInputPage> {
  final TextEditingController _ipController = TextEditingController();
  String? _errorMessage;
  String _deviceID = '';

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

  Future<bool> _validateIp(String ip) async {
    try {
      final response = await http.get(Uri.parse('http://$ip:5000'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<void> _navigateToSignInPage() async {
    final ip = _ipController.text;
    if (ip.isNotEmpty) {
      final isValidIp = await _validateIp(ip);
      if (isValidIp) {
        final response = await http.post(
          Uri.parse('http://$ip:5000/check_device'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'device_id': _deviceID,
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final device_id = data['device_id'];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainApp(
                baseUrl: 'http://$ip:5000',
                device_id: device_id,
              ),
            ),
          );
        } else if (response.statusCode == 404) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpPage(baseUrl: 'http://$ip:5000'),
            ),
          );
        } else {
          _showErrorMessage('Failed to check device ID');
        }
      } else {
        _showErrorMessage('You input a mistaken IP address');
      }
    } else {
      _showErrorMessage('Please enter a valid IP address');
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
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: screenHeight * 0.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: -50,
                        width: screenWidth * 0.58,
                        height: screenHeight * 0.23,
                        child: FadeInUp(
                            duration: Duration(seconds: 1),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/studdent.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.18,
                        child: FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Welcome",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Schyler"),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeInUp(
                          duration: Duration(milliseconds: 1000),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFF277867)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF00a9ac),
                                      blurRadius: 15,
                                      offset: Offset(0, 2))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFF00a9ac)))),
                                  child: TextField(
                                    controller: _ipController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter IP",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[700])),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      GestureDetector(
                        onTap: _navigateToSignInPage,
                        child: FadeInUp(
                            duration: Duration(milliseconds: 1900),
                            child: Container(
                              height: screenHeight * 0.07,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF277867),
                                      Color(0xFF4E998A),
                                    ],
                                    stops: [0.3, 0.8],
                                  )),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Schyler"),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: screenHeight * 0.07,
                      ),
                      if (_errorMessage != null)
                        Container(
                          padding: EdgeInsets.all(16.0),
                          color: Color(0xFF002C31),
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
