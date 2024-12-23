import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iddevice/Pages/home_page.dart';
import 'package:iddevice/Pages/leaderborad_page.dart';
import 'package:iddevice/Pages/profile_page.dart';

class MainApp extends StatefulWidget {
  final String baseUrl;
  final String device_id;

  MainApp({required this.baseUrl, required this.device_id});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    // Dummy initialization
    Profile2Page(baseUrl: '', device_id: ''),
    ProfilePage(baseUrl: '', device_id: ''), // Dummy initialization

    LeaderboardPage(baseUrl: ''),
    ProfilePage(baseUrl: '', device_id: ''), // Dummy initialization
    // Dummy initialization
  ];

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      Profile2Page(baseUrl: widget.baseUrl, device_id: widget.device_id),
      ProfilePage(baseUrl: widget.baseUrl, device_id: widget.device_id),
      LeaderboardPage(baseUrl: widget.baseUrl),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 62,
        color: Color(0xFFe8d2ae),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Color(0xFF0f898c),
        items: [
          Icon(Icons.account_circle, color: Color(0xFF0f898c)),
          Icon(Icons.deblur, color: Color(0xFF0f898c)),
          Icon(Icons.leaderboard, color: Color(0xFF0f898c)),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
