import 'package:flutter/material.dart';

class HomePageIcons extends StatefulWidget {
  final String iconname;
  final IconData icontype;
  final bool isSelected;
  final void Function() onPressed;
  const HomePageIcons({
    Key? key,
    required this.onPressed,
    required this.iconname,
    required this.icontype,
    required this.isSelected,
  }) : super(key: key);
  @override
  State<HomePageIcons> createState() =>
      _HomePageIconsState(onPressed, iconname, icontype, isSelected);
}

class _HomePageIconsState extends State<HomePageIcons> {
  _HomePageIconsState(
      this.onPressed, this.iconname, this.icontype, this.isSelected);
  final String iconname;
  final IconData icontype;
  final bool isSelected;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          child: Icon(icontype, size: 40, color: Colors.white),
          style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            //fixedSize: Size.fromRadius(35),
            backgroundColor: widget.isSelected
                ? const Color(0xffec872b)
                : Colors.transparent,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 3,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          iconname,
          style: TextStyle(
              color: widget.isSelected ? const Color(0xffec872b) : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
