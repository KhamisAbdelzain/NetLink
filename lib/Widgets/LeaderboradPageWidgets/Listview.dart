import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyWidget extends StatelessWidget {
  final String username;
  final String student_id;
  int index;
  MyWidget(
      {required this.username, required this.student_id, required this.index});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: screenHeight * .072,
        width: screenWidth * 1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Color(0xffffffff)),
        child: Row(
          children: [
            SizedBox(
              width: screenWidth * 0.05,
            ),
            SizedBox(
              width: screenWidth * 0.06,
              child: Text(
                "${++index}",
                style: TextStyle(fontFamily: "Schyler", fontSize: 14.sp),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.15,
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 24,
                    backgroundImage: AssetImage("assets/images/unnamed1.png"),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: screenHeight * 1,
              width: screenWidth * 0.6,
              child: Text(
                "$username",
                style: TextStyle(fontFamily: "Schyler", fontSize: 13.sp),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.05,
              child: Text(
                "$student_id",
                style: TextStyle(fontFamily: "Schyler", fontSize: 13.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
