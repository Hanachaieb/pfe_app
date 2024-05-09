// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_app1/pages/ressources/router/router.dart';
import 'package:my_app1/services/AuthServices.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Widget positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: Text(
            "Oui",
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget negative() {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Non",
          style: TextStyle(color: Colors.blueAccent),
        ));
  }

  Future<bool> avoidRteurnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Vous etes sure de sortir"),
            actions: [
              negative(),
              positive(),
            ],
          );
        });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: avoidRteurnButton,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: 111.0, // Adjust width as needed
                ),
              ),
              // Centered content column
              Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20.0), // Spacing above title
                        Text(
                          "Se Connecter",
                          style: TextStyle(
                            fontSize: 33,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: "Myfont",
                          ),
                        ),
                        SizedBox(height: 20.0), // Spacing between title and icon
                        SvgPicture.asset(
                          "assets/icons/login.svg",
                          width: 250.0,
                        ),
                        SizedBox(height: 20.0), // Spacing between icon and form fields
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Colors.purple[800],
                            ),
                            hintText: "Email :",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ce champ est obligatoire';
                            } else if (!value.contains('@') ||
                                !value.contains('.') ||
                                value.indexOf('@') > value.lastIndexOf('.') ||
                                value.indexOf('@') < 1 ||
                                value.length - value.lastIndexOf('.') < 3) {
                              return 'Veuillez saisir un e-mail valide';
                            }
                            return null;
                          },
                          controller: email,
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.visibility,
                              color: Colors.purple[900],
                            ),
                            icon: Icon(
                              Icons.lock,
                              color: Colors.purple[800],
                              size: 19,
                            ),
                            hintText: "Mot de passe :",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Le mot de passe est requis';
                            }
                            return null;
                          },
                          controller: password,
                        ),
                        SizedBox(height: 17.0),
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.purple,
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    AuthServices().signIn(email.text, password.text).then((value) async {
                                      print(value);
                                      if (value) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        AuthServices().getUserData().then((value) {
                                          AuthServices().saveUserLocally(value);
                                          if (value.role == 'Client') {
                                            Navigator.pushNamed(context, AppRouting.HomeClient);
                                          } else {
                                            Get.toNamed(AppRouting.HomeWorker);
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Fluttertoast.showToast(
                                            msg: "Verifier vos données",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    });
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 79, vertical: 10)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(27.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Connecter",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(237, 221, 242, 251),
                                  ),
                                ),
                              ),
                        SizedBox(height: 17.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Nouveau?"),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/sign_up");
                              },
                              child: Text(
                                "  Inscrivez-vous ici !",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
