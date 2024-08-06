import 'package:flutter/material.dart';

class WelcomText extends StatelessWidget {
  const WelcomText({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome to...",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          "BMS Tracker",
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Color(0xffec872b)),
        ),
        Text(
          "Follow and check your car's battery readings, including charge percentage and battery status with great accuracy and instant feedbacks to your car critical status, to ensure protection and safety for your car all with a press of a button...",
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ],
    );
  }
}
