import 'package:bms_tracker/Components/DisplayParameters.dart';
import 'package:bms_tracker/Components/FormoreInfo.dart';
import 'package:bms_tracker/Components/HomePageAppbar.dart';
import 'package:bms_tracker/Components/HomePageIcons.dart';
import 'package:bms_tracker/Components/LocalNotification.dart';
import 'package:bms_tracker/Components/PreviousData.dart';
import 'package:bms_tracker/Components/StateDisplayCard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:bms_tracker/Components/Graph.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _StateHomePage();
}

class _StateHomePage extends State<HomePage> {
  String PackVoltage = "0",
      PackCurrent = "0",
      PackTemp = "0",
      CellVoltage = "0",
      CellCurrent = "0",
      ModuleTemp = "0",
      SoC = "0",
      SoH = "0";

  bool Charging = false, DisCharging = false;

  double latitude = 30.044420, longtide = 31.235712;
  Future<void> _OpenMap(double lat, double long) async {
    String googleURL = 'https://www.google.com/maps/search/$lat,$long';
    if (await canLaunchUrlString(googleURL)) {
      await launchUrlString(googleURL);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    DatabaseReference Data = FirebaseDatabase.instance.ref('BMS');
    Data.onValue.listen((DatabaseEvent event) {
      final data1 = event.snapshot.child('PackVoltage').value.toString();
      final data3 = event.snapshot.child('PackCurrent').value.toString();
      final data5 = event.snapshot.child('PackTemp').value.toString();
      final data7 = event.snapshot.child('ChargingState').value.toString();
      final data8 = event.snapshot.child('SOC').value.toString();
      final data9 = event.snapshot.child('SOH Predicted').value.toString();
      setState(() {
        PackVoltage = data1.length <= 3 ? data1 : data1.substring(0, 5);
        PackCurrent = data3.length <= 3 ? data3 : data3.substring(0, 5);
        PackTemp = data5.length <= 3 ? data5 : data5.substring(0, 5);
        CellVoltage = (double.parse(data1.toString()) / 24).toString().length <=
                3
            ? (double.parse(data1.toString()) / 24).toString()
            : (double.parse(data1.toString()) / 24).toString().substring(0, 5);
        CellCurrent = data3.length <= 3 ? data3 : data3.substring(0, 5);
        ModuleTemp = data5.substring(0, 5);
        SoC = data8.length <= 3 ? data8 : data8.substring(0, 5);
        SoH = data9.length <= 3 ? data9 : data9.substring(0, 5);
        //get charging state
        if (data7.toString() == "0") {
          DisCharging = true;
          Charging = false;
          LocalNotifications.ChargingNotification(
              title: "Warning!",
              body: "Your Car is Currently in use",
              payload: "Your Car is Currently in use");
        } else if (data7.toString() == "1") {
          DisCharging = false;
          Charging = true;
          LocalNotifications.ChargingNotification(
              title: "Warning!",
              body: "Your Car is Currently Charging",
              payload: "Your Car is Currently Charging");
        } else if (data7.toString() == "2") {
          DisCharging = false;
          Charging = false;
          LocalNotifications.ChargingNotification(
              title: "Warning!",
              body: "Your Car is not Charging",
              payload: "Your Car is not Charging");
        }

        //push local notification
        if (double.parse(PackVoltage) > 100.8 ||
            double.parse(PackVoltage) < 60 ||
            double.parse(CellVoltage) > 4.3 ||
            double.parse(CellVoltage) < 2.5) {
          LocalNotifications.VoltageNotification(
              title: "Warning!",
              body: "Voltage is not normal ",
              payload: "Voltage is not normal");
        }
        if (double.parse(PackCurrent) > 2.5 ||
            double.parse(PackCurrent) < 0.5 ||
            double.parse(CellCurrent) > 2.5 ||
            double.parse(CellCurrent) < 0.5) {
          LocalNotifications.CurrentNotification(
              title: "Warning!",
              body: "Current is not normal ",
              payload: "Current is not normal");
        }
        if (double.parse(PackTemp) > 45 ||
            double.parse(PackTemp) < 10 ||
            double.parse(ModuleTemp) > 45 ||
            double.parse(ModuleTemp) < 10) {
          LocalNotifications.TempNotification(
              title: "Warning!",
              body: "Temperature is not normal ",
              payload: "Temperature is not normal");
        }
        if ((double.parse(SoC) * 100) < 20) {
          LocalNotifications.SoCNotification(
              title: "Warning!",
              body: "your battery is running low",
              payload: "your battery is running low");
        }
        if ((double.parse(SoH) * 100) < 50) {
          LocalNotifications.SoHNotification(
              title: "Warning!",
              body: "your battery Health is running low",
              payload: "your battery Health is running low");
        }
      });
    });
  }

  bool icon_color1 = true;
  bool icon_color2 = false;
  double soc_percentage = 0.5;
  double soh_percentage = 0.9;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //backgroundColor: Color(0xff092f19),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff092f19), Color.fromARGB(255, 16, 124, 61)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: ListView(
          children: [
            const HomePageAppbar(),
            const SizedBox(
              height: 30,
            ),
            //icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomePageIcons(
                  iconname: "Battery Status",
                  icontype: Icons.charging_station,
                  isSelected: icon_color1,
                  onPressed: () {
                    setState(() {
                      icon_color1 = true;
                      icon_color2 = false;
                    });
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                HomePageIcons(
                  iconname: "Battery Parameters",
                  icontype: Icons.battery_4_bar_sharp,
                  isSelected: icon_color2,
                  onPressed: () {
                    setState(() {
                      icon_color1 = false;
                      icon_color2 = true;
                    });
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                HomePageIcons(
                  onPressed: () {
                    setState(() {
                      _OpenMap(latitude, longtide);
                    });
                  },
                  iconname: "Car Location",
                  icontype: Icons.location_on,
                  isSelected: false,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            if (icon_color1)
              Card(
                margin: const EdgeInsets.all(5),
                color: const Color.fromARGB(255, 6, 29, 15),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Charging Status:",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 25,
                                    color: Charging
                                        ? const Color(0xffec872b)
                                        : const Color.fromARGB(255, 92, 92, 92),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Charging",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Charging
                                            ? const Color(0xffec872b)
                                            : const Color.fromARGB(
                                                255, 92, 92, 92)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 25,
                                    color: DisCharging
                                        ? const Color(0xffec872b)
                                        : const Color.fromARGB(255, 92, 92, 92),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Discharging",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: DisCharging
                                            ? const Color(0xffec872b)
                                            : const Color.fromARGB(
                                                255, 92, 92, 92)),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      if (Charging == false && DisCharging == false)
                        SizedBox(
                          height: 20,
                        ),
                      if (Charging == false && DisCharging == false)
                        Text(
                          "Your Vehicle is currently parked",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xffec872b)),
                        )
                    ],
                  ),
                ),
              ),
            if (icon_color1) const SizedBox(height: 5),
            if (icon_color1)
              Card(
                margin: const EdgeInsets.all(5),
                color: const Color.fromARGB(255, 6, 29, 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    StateDisplayCard(
                        percentage: double.parse(SoC) / 100,
                        title: "State of Charge",
                        subtitle:
                            "quantifies the remaining capacity available in the battery at real time, acts like a fuel gauge in a car. It informs the users of how much longer they can operate."),
                    ForMoreInfo(
                      graph: "SoC Graph",
                      onPressedGraph: () {
                        setState(() {});
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Graph(
                                  GraphName: "SoC Readings",
                                  PackParameterData: "SOC",
                                )));
                      },
                      onPressedPData: () {
                        setState(() {});
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PreviousData(
                            PackParameter: "SoC",
                            PackParameterData: "SOC",
                            AppBarTitle: "Previous Status Readings",
                          ),
                        ));
                      },
                    )
                  ],
                ),
              ),

            if (icon_color1) const SizedBox(height: 5),
            if (icon_color1)
              Card(
                margin: const EdgeInsets.all(5),
                color: const Color.fromARGB(255, 6, 29, 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    StateDisplayCard(
                        percentage: double.parse(SoH) / 100,
                        title: "State of Health",
                        subtitle:
                            "is a measurement that indicates the level of degradation and remaining capacity of the battery."),
                    ForMoreInfo(
                      graph: "SoH Graph",
                      onPressedGraph: () {
                        setState(() {});
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Graph(
                                  GraphName: "SoH Readings",
                                  PackParameterData: "SOH Predicted",
                                )));
                      },
                      onPressedPData: () {
                        setState(() {});
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PreviousData(
                            PackParameter: "SoH",
                            PackParameterData: "SOH Predicted",
                            AppBarTitle: "Previous Status Readings",
                          ),
                        ));
                      },
                    )
                  ],
                ),
              ),
            if (icon_color2)
              Card(
                margin: const EdgeInsets.all(5),
                color: const Color.fromARGB(255, 6, 29, 15),
                child: Column(
                  children: [
                    DisplayParameters("Cell Voltage", "Pack Voltage",
                        CellVoltage, PackVoltage, "Voltage Readings"),
                    ForMoreInfo(
                      graph: "Voltage Graph",
                      onPressedGraph: () {
                        setState(() {});
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Graph(
                                  GraphName: "Pack Voltage Readings",
                                  PackParameterData: "PackVoltage",
                                )));
                      },
                      onPressedPData: () {
                        setState(() {});
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PreviousData(
                            PackParameter: "Pack Voltage",
                            PackParameterData: "PackVoltage",
                            AppBarTitle: "Previous Voltage Readings",
                          ),
                        ));
                      },
                    ),
                  ],
                ),
              ),
            if (icon_color2)
              Card(
                margin: const EdgeInsets.all(5),
                color: const Color.fromARGB(255, 6, 29, 15),
                child: Column(
                  children: [
                    DisplayParameters("Cell Current", "Pack Current",
                        CellCurrent, PackCurrent, "Current Readings"),
                    ForMoreInfo(
                      graph: "Current Graph",
                      onPressedGraph: () {
                        setState(() {});
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Graph(
                                  GraphName: "Pack Current Readings",
                                  PackParameterData: "PackCurrent",
                                )));
                      },
                      onPressedPData: () {
                        setState(() {});
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PreviousData(
                            PackParameter: "Pack Current",
                            PackParameterData: "PackCurrent",
                            AppBarTitle: "Previous Current Readings",
                          ),
                        ));
                      },
                    ),
                  ],
                ),
              ),
            if (icon_color2)
              SizedBox(
                height: 1,
              ),
            if (icon_color2)
              Card(
                margin: const EdgeInsets.all(5),
                color: const Color.fromARGB(255, 6, 29, 15),
                child: Column(
                  children: [
                    DisplayParameters("Module Temp", "Pack Temp", ModuleTemp,
                        PackTemp, "Temperature Readings"),
                    ForMoreInfo(
                      graph: "Temp Graph",
                      onPressedGraph: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Graph(
                                    GraphName: "Pack Temperature Readings",
                                    PackParameterData: "PackTemp",
                                  )));
                        });
                      },
                      onPressedPData: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PreviousData(
                              PackParameter: "Pack Temp",
                              PackParameterData: "PackTemp",
                              AppBarTitle: "Previous Temperature Readings",
                            ),
                          ));
                        });
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
