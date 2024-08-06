import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PreviousData extends StatefulWidget {
  final String PackParameter, PackParameterData, AppBarTitle;

  const PreviousData(
      {super.key,
      required this.PackParameter,
      required this.PackParameterData,
      required this.AppBarTitle});

  @override
  State<PreviousData> createState() =>
      _StatePreviousData(PackParameter, PackParameterData, AppBarTitle);
}

class _StatePreviousData extends State<PreviousData> {
  final String PackParameter, PackParameterData, AppBarTitle;

  _StatePreviousData(
      this.PackParameter, this.PackParameterData, this.AppBarTitle);

  Future<List> GetData() async {
    var response = await get(Uri.parse(
        "https://script.google.com/macros/s/AKfycbwefkOvp4jvdZ2aop99yUVTw5kx-ptub-rXzvNRxOzDkYzJTQFragIpEKAt3VL2FBi4YQ/exec"));
    var responsebody = jsonDecode(response.body);
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
          "$AppBarTitle",
          style:
              TextStyle(color: Color(0xffec872b), fontWeight: FontWeight.bold),
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
                child: CircularProgressIndicator(
                  color: Color(0xffec872b),
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                        decoration: BoxDecoration(color: Color(0xffec872b)),
                        children: [
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "$PackParameter",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff092f19),
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "Date",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff092f19),
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ]),
                    ...List.generate(
                        snapshot.data!.length,
                        (index) => TableRow(children: [
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    snapshot.data![index]['$PackParameterData']
                                                .toString()
                                                .length <=
                                            3
                                        ? snapshot.data![index]
                                                ['$PackParameterData']
                                            .toString()
                                        : snapshot.data![index]
                                                ['$PackParameterData']
                                            .toString()
                                            .substring(0, 4),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date: ${snapshot.data![index]['Date'].substring(0, 10)}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Time: ${snapshot.data![index]['Date'].split('T')[1].substring(0, 5)}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ]))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
