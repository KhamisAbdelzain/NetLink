import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:iddevice/Widgets/LeaderboradPageWidgets/Listview.dart';
import 'package:iddevice/Widgets/LeaderboradPageWidgets/buildAvatarColumn.dart';

class LeaderboardPage extends StatelessWidget {
  final String baseUrl;

  LeaderboardPage({required this.baseUrl});

  Future<List<dynamic>> _fetchLeaderboard() async {
    final response = await http.get(Uri.parse('$baseUrl/leaderboard'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load leaderboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return FutureBuilder<List<dynamic>>(
      future: _fetchLeaderboard(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final leaderboard = snapshot.data!;
          final topUser = leaderboard.isNotEmpty ? leaderboard[0] : null;
          final SecondUser = leaderboard.isNotEmpty ? leaderboard[1] : null;
          final ThirdUser = leaderboard.isNotEmpty ? leaderboard[2] : null;

          return Scaffold(
              body: Container(
            height: screenHeight * 1,
            width: screenWidth * 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFe8d2ae), Color(0xFF0F898C)],
                stops: [0.3, 0.8],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Container(
                    height: screenHeight * 1,
                    width: screenWidth * 1,
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        SizedBox(
                          height: screenHeight * 0.1,
                          child: Center(
                            child: Text(
                              "Leaderboard",
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  color: Color(0xFF002C31),
                                  fontFamily: "Schyler"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Container(
                          height: screenHeight * 0.21,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (topUser != null &&
                                  SecondUser != null &&
                                  ThirdUser != null)
                                buildAvatarColumn(
                                    "${ThirdUser['username'].split(' ').first}",
                                    "${ThirdUser['No_of_Presence']}",
                                    40,
                                    'third_medal.png'),
                              buildAvatarColumn(
                                  "${topUser['username'].split(' ').first}",
                                  "${topUser['No_of_Presence']}",
                                  55,
                                  'first_medal.png'),
                              buildAvatarColumn(
                                  "${SecondUser['username'].split(' ').first}",
                                  "${SecondUser['No_of_Presence']}",
                                  50,
                                  'secound_medal.png'),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2.0),
                          child: SizedBox(
                            height: screenHeight * 0.04,
                            child: Text(
                              "Show up, Stand out, Succeed!",
                              style: TextStyle(
                                fontFamily: "Schyler",
                                color: Color(0xFF002C31),
                                fontSize: 17.sp,
                              ),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            height: screenHeight * 0.45,
                            child: ListView.builder(
                              itemCount: leaderboard.length,
                              itemBuilder: ((context, index) {
                                final user = leaderboard[index];
                                return MyWidget(
                                  index: index,
                                  username: "${user['username']}",
                                  student_id: "${user['No_of_Presence']}",
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
              ],
            ),
          ));
        }
      },
    );
  }
}
