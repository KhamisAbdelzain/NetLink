import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:iddevice/Widgets/profile_details.dart';

class Profile2Page extends StatelessWidget {
  final String baseUrl;
  final String device_id;

  Profile2Page({required this.baseUrl, required this.device_id});

  Future<Map<String, dynamic>> _fetchProfile2() async {
    final response =
        await http.get(Uri.parse('$baseUrl/profile2?device_id=$device_id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load profile2');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchProfile2(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final profile2 = snapshot.data!;
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: screenHeight * 1,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color(0xFFe8d2ae), Color(0xFF0f898c)],
                  stops: [
                    0.3,
                    0.8
                  ], // Adjust these values to control the mixture
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                              height: screenHeight * 0.18,
                              width: screenWidth * .4,
                              child:
                                  Image.asset("assets/images/netlinklogo.png")),
                          Container(
                            height: screenHeight * 0.22,
                            width: screenWidth * 0.414,
                            child: Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                maxRadius: 300,
                                backgroundImage:
                                    AssetImage('assets/images/unnamed1.png'),
                              ),
                            ),
                          ),
                          Text(
                            "${profile2['username']}",
                            style: TextStyle(
                                color: Color(0xFF005b5f),
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Schyler"),
                          ),
                          SizedBox(
                            height: screenHeight * 0.008,
                          ),
                          ProfileDetails(
                              userparameter: "ID",
                              uservalue: "${profile2['student_id']}"),
                          ProfileDetails(
                              userparameter: "Email",
                              uservalue: "${profile2['email']}"),
                          ProfileDetails(
                              userparameter: "Academic Year",
                              uservalue: "${profile2['academic_year']}"),
                          SizedBox(
                            height: screenHeight * 0.005,
                          ),
                          Divider(
                            color: Colors.white60,
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Text(
                            '"You are capable of achieving greatness. Each day of attendance is a step closer to your goals. Keep going!"',
                            style: TextStyle(
                                color: Color(
                                  0xFF005b5f,
                                ),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Schyler"),
                          ),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
