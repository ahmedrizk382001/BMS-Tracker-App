import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StateDisplayCard extends StatelessWidget {
  const StateDisplayCard(
      {super.key,
      required this.percentage,
      required this.title,
      required this.subtitle});
  final double percentage;
  final String title, subtitle;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: CircularPercentIndicator(
            animation: true,
            animationDuration: 1000,
            radius: 150,
            lineWidth: 15,
            percent: percentage,
            progressColor: const Color(0xffec872b),
            backgroundColor: const Color.fromARGB(255, 92, 92, 92),
            circularStrokeCap: CircularStrokeCap.round,
            center: Text(
              "${(percentage * 100).toInt()}%",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        Expanded(
            child: ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        )),
      ],
    );
  }
}
