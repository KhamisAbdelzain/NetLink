import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalDetials extends StatelessWidget {
  GlobalDetials(
      {super.key,
      required this.State,
      required this.score,
      required this.font});
  final String State;
  final String score;
  final String font;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Container(
      padding: EdgeInsets.all(2),
      width: screenWidth * 0.27,
      height: screenHeight * 0.1,
      child: Column(
        children: [
          Text(
            State,
            style: TextStyle(
              fontFamily: "Schyler",
              fontSize: 15.sp,
              color: Color(0xFF002C31),
            ),
          ),
          SizedBox(
            height: screenHeight * .009,
          ),
          Text(
            score,
            style: TextStyle(
                fontSize: 20.sp,
                color: Color(0xFF002C31),
                fontWeight: FontWeight.w500,
                fontFamily: font),
          ),
        ],
      ),
    );
  }
}
