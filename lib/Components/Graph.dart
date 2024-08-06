import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {
  final String GraphName, PackParameterData;
  const Graph(
      {super.key, required this.GraphName, required this.PackParameterData});

  @override
  State<Graph> createState() =>
      _GraphState(this.GraphName, this.PackParameterData);
}

class _GraphState extends State<Graph> {
  List<Map<String, dynamic>> Data = [];

  final String GraphName, PackParameterData;
  _GraphState(this.GraphName, this.PackParameterData);

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse(
        "https://script.google.com/macros/s/AKfycbwefkOvp4jvdZ2aop99yUVTw5kx-ptub-rXzvNRxOzDkYzJTQFragIpEKAt3VL2FBi4YQ/exec"));
    if (response.statusCode == 200) {
      Data = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return Data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      setState(() {
        Data = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color.fromARGB(255, 6, 29, 15),
        appBar: AppBar(
          leading: IconButton(
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_rounded),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff092f19),
          title: Text(
            "$GraphName",
            style: TextStyle(
                color: Color(0xffec872b), fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff092f19), Color.fromARGB(255, 16, 124, 61)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Color(0xffec872b),
                )); // Show loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Show error message
              } else {
                return SfCartesianChart(
                  enableAxisAnimation: true,
                  primaryXAxis: NumericAxis(
                      axisLine: AxisLine(width: 2, color: Colors.white),
                      labelStyle: TextStyle(
                          color: Color(0xffec872b),
                          fontWeight: FontWeight.bold)),
                  primaryYAxis: NumericAxis(
                      axisLine: AxisLine(width: 2, color: Colors.white),
                      labelStyle: TextStyle(
                          color: Color(0xffec872b),
                          fontWeight: FontWeight.bold)),
                  series: <LineSeries<Map<String, dynamic>, num>>[
                    LineSeries<Map<String, dynamic>, num>(
                      animationDuration: 1000,
                      dataSource: Data,
                      xValueMapper: (double, _) => double['Index'],
                      yValueMapper: (double, _) => double['$PackParameterData'],
                      color: Color(0xffec872b),
                    )
                  ],
                );
              }
            },
          ),
        ));
  }
}
