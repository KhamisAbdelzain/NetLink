import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyDetails extends StatelessWidget {
  DailyDetails({
    super.key,
    required this.time,
    required this.time_comment,
    required this.time_state,
    required this.time_note,
    required this.icon,
  });
  final String time;
  final String time_comment;
  final String time_state;
  final String time_note;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            width: screenWidth * 0.85,
            height: screenHeight * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF002C31),
                      fontWeight: FontWeight.w900,
                      fontFamily: 'khamis2'),
                ),
                   SizedBox(
                    height: screenHeight * 0.004,
                  ),
                Text(
                  time_comment,
                  style: TextStyle(
                      fontFamily: "Schyler",
                      fontSize: 8.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color(0XFFffffff)),
          height: screenHeight * 0.09,
          width: screenWidth * 0.50, // Adjust the height as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.001,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: screenHeight * 0.056,
                      width: screenWidth * 0.25,
                      child: Text(
                        time_state,
                        style: TextStyle(
                            fontFamily: "Schyler",
                            fontSize: 14.8.sp,
                            color: Color(0xFF002C31),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      height: screenHeight * 0.020,
                      width: screenWidth * 0.25,
                      child: Text(
                        time_note,
                        style: TextStyle(
                            fontFamily: "Schyler",
                            fontSize: 8.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(flex: 2, child: icon),
            ],
          ),
        )
      ],
    );
  }
}
