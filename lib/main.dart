
import 'package:flutter/material.dart';
import 'package:weatherapp/weather.dart';
import 'package:weatherapp/weather_3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Weather(),
    );
  }
}
