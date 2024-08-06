import 'package:flutter/material.dart';

class ForMoreInfo extends StatefulWidget {
  final String graph;
  final void Function() onPressedGraph, onPressedPData;

  const ForMoreInfo({
    Key? key,
    required this.graph,
    required this.onPressedGraph,
    required this.onPressedPData,
  }) : super(key: key);

  @override
  State<ForMoreInfo> createState() =>
      _ForMoreInfoState(graph, onPressedGraph, onPressedPData);
}

class _ForMoreInfoState extends State<ForMoreInfo> {
  _ForMoreInfoState(this.graph, this.onPressedGraph, this.onPressedPData);

  final String graph;

  final void Function() onPressedGraph, onPressedPData;
  bool _expanded = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ExpansionTile(
        trailing: Icon(
          _expanded
              ? Icons.arrow_drop_down_circle_outlined
              : Icons.arrow_drop_up,
          color: _expanded ? Colors.white : Color(0xffec872b),
        ),
        onExpansionChanged: (bool expanded) {
          setState(() => _expanded = !_expanded);
        },
        shape: Border.all(width: 0, color: Colors.transparent),
        childrenPadding: EdgeInsets.all(15),
        title: Text(
          _expanded ? "Show more details..." : "Show less...",
          style: TextStyle(
              fontSize: 20, color: _expanded ? Colors.white : Colors.white54),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onPressedPData,
                child: Text(
                  "previous Reading",
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xffec872b),
                      fontWeight: FontWeight.bold),
                ),
                /*style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(
                      color: Color(0xffec872b),
                    )),*/
              ),
              TextButton(
                onPressed: onPressedGraph,
                child: Text(
                  graph,
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xffec872b),
                      fontWeight: FontWeight.bold),
                ),
                /*style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(
                      color: Color(0xffec872b),
                    )),*/
              ),
            ],
          ),
        ],
      ),
    );
  }
}
