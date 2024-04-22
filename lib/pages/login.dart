// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  String? _emailErrorText;
  String? _passwordErrorText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: 111.0,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        "Se Connecter",
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      SvgPicture.asset(
                        "assets/icons/login.svg",
                        width: 250.0,
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.purple[800],
                            ),
                            hintText: "Votre E-mail :",
                            border: InputBorder.none,
                            errorText: _emailErrorText,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ce champ est obligatoire';
                            }
                            if (!_isValidEmail(value)) {
                              return 'Veuillez saisir un e-mail valide';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 23.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            suffix: Icon(
                              Icons.visibility_off,
                              color: Colors.purple[900],
                            ),
                            icon: Icon(
                              Icons.lock,
                              color: Colors.purple[800],
                              size: 19,
                            ),
                            hintText: "Votre mot de passe :",
                            border: InputBorder.none,
                            errorText: _passwordErrorText,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ce champ est obligatoire';
                            }
                            if (!_isValidPassword(value)) {
                              return 'Le mot de passe invalide';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 17.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _emailErrorText = _emailController.text.isEmpty
                                ? 'Ce champ est obligatoire'
                                : null;
                            _passwordErrorText =
                                _passwordController.text.isEmpty
                                    ? 'Ce champ est obligatoire'
                                    : null;
                          });

                          if (_formKey.currentState!.validate()) {
                            // Proceed with login process
                            Navigator.popAndPushNamed(context, "/acceuil");
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              horizontal: 106.0,
                              vertical: 10.0,
                            ),
                          ),
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
                              Navigator.pushNamed(context, "/signup");
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
                width: 111.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    // Check if password contains at least 8 characters and a combination of letters and digits
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return passwordRegex.hasMatch(password);
  }
}
