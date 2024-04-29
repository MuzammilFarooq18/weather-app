import 'package:flutter/material.dart';
import 'package:weather_app/splash_screen.dart';

void main() {
  runApp(const weather_App());
}

class weather_App extends StatelessWidget {
  const weather_App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash_screen(),
    );
  }
}
