import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';

import 'dart:convert';
import 'package:http/http.dart';

class Graph extends StatefulWidget {
  final String CellData, GraphName;
  final List<String> Ylist;
  Graph(
      {super.key,
      required this.CellData,
      required this.GraphName,
      required this.Ylist});

  @override
  State<Graph> createState() =>
      _StateGraph(this.CellData, this.GraphName, this.Ylist);
}

class _StateGraph extends State<Graph> {
  List<double> Data = [];
  List<double> Data2 = [];
  List<String> Time = [];

  _StateGraph(this.CellData, this.GraphName, this.Ylist);
  final String CellData, GraphName;
  final List<String> Ylist;

  Future<List> GetData() async {
    var response = await get(Uri.parse(
        "https://script.google.com/macros/s/AKfycbzlyr3QYDp0-kNWdW-b-PZQ4JJIiFKcrBKDLyVQuAGgpS29oTz4JnndCICQJjsVIakf_w/exec"));
    var responsebody = jsonDecode(response.body);
    responsebody.forEach((element) {
      Data.add(element['$CellData'].toDouble() / 1.0);
      Time.add(element['date'].split('T')[1].substring(0, 5));
    });
    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
          child: FutureBuilder<List>(
              future: GetData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(15),
                      reverse: true,
                      child: LineGraph(
                        features: [
                          Feature(
                              color: Color(0xffec872b),
                              data: List.from(Data.reversed))
                        ],
                        size: Size((Data.length * 70).toDouble(), 400),
                        labelX: List.from(Time.reversed),
                        labelY: Ylist,
                        graphColor: Color(0xffec872b),
                        graphOpacity: 0.2,
                      ),
                    );
                  },
                );
              }),
        ));
  }
}
