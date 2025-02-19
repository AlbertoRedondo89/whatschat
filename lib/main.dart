import 'package:flutter/material.dart';
import 'dart:async';
import 'package:whatschat/pages/loginpage.dart';
import 'package:whatschat/theme/theme.dart';
import 'package:whatschat/preferences/preferences.dart';
import 'package:whatschat/services/notification_service.dart';

void main() async{
  // This line is required when doing async operations in main
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize preferences
  await initNotifications();
  await Preferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(size: 100),
      ),
    );
  }
}