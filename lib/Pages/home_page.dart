import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:iddevice/Widgets/HomePage_Widgets/daily_details.dart';
import 'package:iddevice/Widgets/HomePage_Widgets/global_detiles.dart';
import 'package:iddevice/Widgets/HomePage_Widgets/current_data.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
// Define the time format
String formattedTime = DateFormat('h:mm a').format(now);

class ProfilePage extends StatelessWidget {
  final String baseUrl;
  final String device_id;

  ProfilePage({required this.baseUrl, required this.device_id});

  Future<Map<String, dynamic>> _fetchProfile() async {
    final response =
        await http.get(Uri.parse('$baseUrl/profile?device_id=$device_id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final profile = snapshot.data!;
          return Scaffold(
            body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFe8d2ae),
                      Color(0xFF0f898c)
                    ], // Colors for the gradient
                    stops: [
                      0.3,
                      0.8
                    ], // Adjust these values to control the mixture
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * .015,
                    ),
                    Container(
                      width: screenWidth * 1,
                      height: screenHeight * 0.20,
                      child: Row(
                        children: [
                          Spacer(
                            flex: 1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align children to the start (left)
                            children: [
                              Container(
                                  height: screenHeight * 0.05,
                                  child: Text("N",
                                      style: TextStyle(
                                          fontSize: 32.sp,
                                          color: Color(0xFF0f898c),
                                          fontFamily: 'Khamis'))),
                              Container(
                                  height: screenHeight * 0.07,
                                  child: Text(
                                    "Morning, ${profile['username'].split(' ').first}",
                                    style: TextStyle(
                                      fontFamily: "Schyler",
                                      fontSize: 29.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )),
                              Container(
                                  height: screenHeight * 0.04,
                                  child: Text("Let's be productive today!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Schyler",
                                          fontSize: 10.sp,
                                          color: Colors.white))),
                            ],
                          ),
                          Spacer(
                            flex: 4,
                          ),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage('assets/images/unnamed1.png'),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFFf5e6c7)),
                        width: screenWidth * .95,
                        height: screenHeight * .692,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12),
                                  width: screenWidth * 0.50,
                                  height: screenHeight * .07,
                                  child: Text(
                                    "Overview",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Color(0xFF002C31),
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'khamis3'),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.07,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: screenHeight * 0.001,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color(0XFFFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      padding: EdgeInsets.all(6),
                                      width: screenWidth * 0.35,
                                      height: screenHeight * .06,
                                      child: Row(
                                        children: [
                                          SizedBox(width: screenWidth * 0.03),
                                          CurrenMonthWidget(),
                                          SizedBox(width: screenWidth * 0.03),
                                          const Icon(
                                            Icons.date_range,
                                            color: Color(0xFF0f898c),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.05,
                                ),
                                GlobalDetials(
                                    State: "Presence",
                                    score: "${profile['No_of_Presence']}",
                                    font: 'khamis2'),
                                Container(
                                  height: screenHeight * .07,
                                  width: screenWidth * 0.03,
                                  child: const VerticalDivider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                GlobalDetials(
                                    State: "Absence",
                                    score: "${profile['No_of_Absence']}",
                                    font: 'khamis2'),
                                Container(
                                  height: screenHeight * 0.07,
                                  width: screenWidth * 0.02,
                                  child: const VerticalDivider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                GlobalDetials(
                                    State: "Lateness",
                                    score:
                                        "${profile['total_time_of_Lateness']} Min",
                                    font: 'khamis2')
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.000,
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              height: screenHeight * 0.51,
                              width: screenWidth * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xFFf6efdc)),
                              child: Column(children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * .030,
                                    ),
                                    Container(
                                      width: screenWidth * 0.81,
                                      height: screenHeight * 0.038,
                                      child: CurrentDateWidget(),
                                    )
                                  ],
                                ),
                                DailyDetails(
                                  time: "${profile['Check_in_time']}",
                                  time_comment: "Actual check in",
                                  time_state: "Check In",
                                  time_note: "${profile['Comment']}",
                                  icon: const Icon(
                                    Icons.share_arrival_time_outlined,
                                    size: 30,
                                    color: Color(0xFF0f898c),
                                  ),
                                ),
                                DailyDetails(
                                  time: "${profile['Break_time']}",
                                  time_comment: "time is now $formattedTime",
                                  time_state: "Break",
                                  time_note: "Stay focused",
                                  icon: const Icon(
                                    Icons.coffee_maker_outlined,
                                    size: 30,
                                    color: Color(0xFF0f898c),
                                  ),
                                ),
                                DailyDetails(
                                  time: "${profile['lecture_end']}",
                                  time_comment: "See You Next Time",
                                  time_state: "Lecture End",
                                  time_note: "time is now $formattedTime",
                                  icon: const Icon(
                                    Icons.flash_on_outlined,
                                    size: 30,
                                    color: Color(0xFF0f898c),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Color(0XFFffffff)),
                                        height: screenHeight * 0.14,
                                        width: screenWidth *
                                            .65, // Adjust the height as needed
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: screenHeight*0.9,
                                                width: screenWidth*0.9,
                                                child: Center(
                                                  child: Text(
                                                    "Note : ",
                                                    style: TextStyle(
                                                        fontSize: 22.sp,
                                                        color:
                                                            Color(0xFF002C31),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: "Schyler"),
                                                  ),
                                                ),
                                              ),
                                            ),  
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: screenHeight*0.9,
                                                width: screenWidth*0.9,
                                                child: Text(
                                                  maxLines: 3,
                                                  "${profile['note_today']}",
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color:
                                                          Color(0xFF002C31),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: "Schyler"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ]),
                            ),
                             SizedBox(
                              height: screenHeight*0.009,
                            )
                          ],
                        )),
                  ],
                )),
          );
        }
      },
    );
  }
}
