import 'package:flutter/material.dart';
import 'package:weather_app/home/first_screen.dart';
import 'dart:async';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => first_screen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  Colors.white,
                ],
              ),
            ),
          ),
          const Center(
            child: Icon(
              Icons.cloud,
              size: 150.0,
              color: Colors.white,
            ),
          ),
          const Positioned(
            top: 460,
            left: 12,
            child: Text(
              "Let's Explore Weather Together!",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 6, 79, 161),
              ),
            ),
          ),
          const Positioned(
              top: 49,
              left: 250,
              child: Icon(
                size: 100,
                Icons.sunny,
                color: Color.fromARGB(255, 241, 227, 20),
              )),
          const Positioned(
            top: 65,
            left: 255,
            child: Icon(
              Icons.cloud,
              size: 120.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
