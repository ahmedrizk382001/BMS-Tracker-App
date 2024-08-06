import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm(
      {super.key,
      required this.hinttext,
      required this.mycontroller,
      required this.obscuretext});

  final String hinttext;
  final TextEditingController mycontroller;
  final bool obscuretext;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
        minLines: 1,
        maxLines: 1,
        obscureText: obscuretext,
        controller: mycontroller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, right: 20),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.black45, width: 1),
          ),
          hintText: hinttext,
          hintStyle: const TextStyle(color: Color(0xff717170)),
        ));
  }
}




/*validator: (value) {
                                if (value!.isEmpty) {
                                  return "please! type your ID";
                                } else if (value != password) {
                                  return "Wrong password";
                                }
                              },*/