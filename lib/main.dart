import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:whatschat/pages/loginpage.dart';
import 'package:whatschat/providers/boton_grupos_provider.dart';
import 'package:whatschat/providers/preferencesprovider.dart';
import 'package:whatschat/theme/theme.dart';
import 'package:whatschat/preferences/preferences.dart';
import 'package:whatschat/services/notification_service.dart';
import 'package:whatschat/providers/themeprovider.dart';
import 'package:whatschat/providers/apiprovider.dart';

void main() async{
  // This line is required when doing async operations in main
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize preferences
  await initNotifications();
  await Preferences.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PreferencesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ApiProvider(baseUrl: 'https://apifac.onrender.com')),
        ChangeNotifierProvider(create: (_) => BotonGruposProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí usamos el tema proporcionado por el ThemeProvider
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.currentTheme,  // Obtiene el tema actual
          home: SplashScreen(),
        );
      },
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
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}