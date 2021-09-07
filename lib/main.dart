import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_sensors/screens/home_screen.dart';
import 'package:camera/camera.dart';
import 'package:mobile_sensors/screens/sign_in_screen.dart';

List<CameraDescription> cameras = [];

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile_sensors',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFF1EABA),
      ),
      home: Homescreen(cameras),
      // home: SignInScreen(),

    );
  }
}