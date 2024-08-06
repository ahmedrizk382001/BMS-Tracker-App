import 'package:flutter/material.dart';

class DisplayParameters extends StatelessWidget {
  const DisplayParameters(this.cellParameter, this.packParameter,
      this.cellValue, this.packValue, this.cardName);
  final String cellParameter, packParameter, cellValue, packValue, cardName;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            cardName,
            style: TextStyle(fontSize: 25, color: Color(0xffec872b)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    cellValue,
                    style: const TextStyle(fontSize: 50, color: Colors.white),
                  ),
                  Text(
                    cellParameter,
                    style:
                        const TextStyle(fontSize: 20, color: Color(0xffec872b)),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    packValue,
                    style: const TextStyle(fontSize: 50, color: Colors.white),
                  ),
                  Text(
                    packParameter,
                    style:
                        const TextStyle(fontSize: 20, color: Color(0xffec872b)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
