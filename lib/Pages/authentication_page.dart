import 'package:flutter/material.dart';
import 'package:iddevice/Pages/ip_login_page.dart';
import 'package:iddevice/Services/authentication.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFe8d2ae),
                    Color(0xFF0f898c),
                  ],
                  stops: [
                    0.3,
                    0.8
                  ], // Adjust these values to control the mixture
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.3,
                        width: screenWidth * 0.55,
                        child: Image.asset("assets/images/netlinklogo.png"),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Text(
                        "Login Page",
                        style: TextStyle(
                          color: Color(0xFF005b5f),
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Schyler",
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        "use your fingerprint to login",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xFF005b5f),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Schyler",
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      const Divider(
                        color: Colors.white60,
                      ),
                      SizedBox(height: screenHeight * 0.09),
                      Builder(
                        builder: (context) {
                          return ElevatedButton.icon(
                            onPressed: () async {
                              bool auth = await Authentication.authentication();
                              print("can authentications:$auth");
                              if (auth) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => IpInputApp(),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.fingerprint,
                              color: Color(0xFF005b5f),
                            ),
                            label: const Text(
                              "Authenticate",
                              style: TextStyle(
                                color: Color(0xFF005b5f),
                                fontFamily: "Schyler",
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
