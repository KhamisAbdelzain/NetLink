import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetails extends StatelessWidget {
  final String userparameter;
  final String uservalue;

  ProfileDetails(
      {super.key, required this.userparameter, required this.uservalue});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: screenHeight * 0.09,
        width: screenWidth * 1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Color(0xFFe8d2ae)),
        child: Row(
        
          children: [
            SizedBox(
              width: screenWidth * 0.05,
            ),
            SizedBox(
              width: screenWidth * 0.33,
              child: Text(
                "$userparameter",
                style: TextStyle(
                  fontFamily: "Schyler",
                  fontSize: 16.sp,
                  color: Color(0xFF002C31),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: screenWidth * 0.44,
              child: Text(
                maxLines: 3,
                
                "$uservalue",
                style: TextStyle(
                overflow: TextOverflow.ellipsis,
                  fontFamily: "Schyler",
                  fontSize: 15.sp,
                  color: Color(0xFF002C31),
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
