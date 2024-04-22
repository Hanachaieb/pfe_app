// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logint extends StatefulWidget {
  const Logint({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Logint> {
  final _formKey = GlobalKey<FormState>();

  String? _username;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Top image (assuming it's positioned at the top-left)
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
                      SizedBox(
                          height: 20.0), // Spacing between icon and form fields
                      TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.purple[800],
                          ),
                          hintText: "Nom d'utilisateur :",
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 3) {
                            return 'Le nom d\'utilisateur est requis et doit contenir au moins 3 caractères';
                          }
                          return null;
                        },
                        onSaved: (value) => _username = value,
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
                        onSaved: (value) => _password = value,
                      ),
                      SizedBox(height: 17.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Validation successful, proceed with form submission
                            // Add your form submission logic here
                            Navigator.pushNamed(context, "/comptet");
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 79, vertical: 10)),
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
                              Navigator.pushNamed(context, "/signupt");
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
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: 111.0, // Adjust width as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
