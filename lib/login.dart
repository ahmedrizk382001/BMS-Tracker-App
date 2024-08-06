import 'package:bms_tracker/Components/TextFormField.dart';
import 'package:bms_tracker/Components/logo.dart';
import 'package:bms_tracker/Components/welcomtext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(50),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff092f19), Color.fromARGB(255, 16, 124, 61)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Logo(),
              SizedBox(
                height: 50,
              ),
              const WelcomText(),
              SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextForm(
                      hinttext: "Enter your email",
                      mycontroller: email,
                      obscuretext: false),
                  Container(
                    height: 20,
                  ),
                  CustomTextForm(
                      hinttext: "Enter your password",
                      mycontroller: password,
                      obscuretext: true),
                  Container(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        Navigator.of(context).pushReplacementNamed("HomePage");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == e.code) {
                          //print('No user found for that email.');
                          // ignore: use_build_context_synchronously
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'email or password is incorrect',
                          ).show();
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffec872b),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
