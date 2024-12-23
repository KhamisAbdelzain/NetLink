import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildAvatarColumn(
    String name, String student_id, double avatarRadius, String medalIconPath) {
  return Column(
    children: [
      Spacer(flex: 1),
      Stack(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/images/unnamed1.png"),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/icons/$medalIconPath',
              height: avatarRadius * 0.75,
              width: avatarRadius * 0.75,
            ),
          ),
        ],
      ),
      Text(name, style: TextStyle(fontFamily: "Schyler", fontSize: 15.sp)),
      Text(
        student_id,
        style: TextStyle(fontFamily: "Schyler", fontSize: 13.sp),
      ),
      Spacer(flex: 1),
    ],
  );
}
