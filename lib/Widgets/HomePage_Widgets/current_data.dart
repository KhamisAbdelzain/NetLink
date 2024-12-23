import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentDateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime now = DateTime.now();
    // Define the date format
    String formattedDate = DateFormat('EEEE d MMMM y').format(now);

    return Text(
      formattedDate,
      style: TextStyle(
        fontFamily: "Schyler",
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class CurrentTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current time
    DateTime now = DateTime.now();
    // Define the time format
    String formattedTime = DateFormat('h:mm a').format(now);

    return Text(
      'It is now $formattedTime',
      style: TextStyle(
          fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500),
    );
  }
}

class CurrenMonthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime now = DateTime.now();
    // Define the date format
    String formattedDate = DateFormat('MMMM yyyy').format(now);

    return Text(
      formattedDate,
      style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontFamily: 'khamis2',
          fontWeight: FontWeight.w600),
    );
  }
}
