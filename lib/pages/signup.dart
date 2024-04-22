import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                        "Inscription",
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      SvgPicture.asset(
                        "assets/icons/signup.svg",
                        height: 200.0,
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
                            hintText: "Votre Email :",
                            border: InputBorder.none,
                            errorText: _emailErrorText,
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
                              Icons.visibility,
                              color: Colors.purple[900],
                            ),
                            icon: Icon(
                              Icons.lock,
                              color: Colors.purple[800],
                              size: 19,
                            ),
                            hintText: "Votre Mot de Passe :",
                            border: InputBorder.none,
                            errorText: _passwordErrorText,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ce champ est obligatoire';
                            } else if (value.length < 8 ||
                                !value.contains(RegExp(r'[a-zA-Z]')) ||
                                !value.contains(RegExp(r'[0-9]'))) {
                              return 'Le mot de passe invalide';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 17.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Proceed with signup process
                            Navigator.pushNamed(context, "/acceuil");
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 106, vertical: 10),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27),
                            ),
                          ),
                        ),
                        child: Text(
                          "Inscription",
                          style: TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(237, 221, 242, 251),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Déjà inscrit ? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/login");
                            },
                            child: Text(
                              "Connectez-vous !",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      SizedBox(
                        width: 299,
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.6,
                                color: Colors.purple,
                              ),
                            ),
                            Text(
                              "Ou",
                              style: TextStyle(color: Colors.purple),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.6,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 17.0),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.purple, width: 1),
                              ),
                              child: SvgPicture.asset(
                                "assets/AAAA/facebook.svg",
                                color: Colors.purple[400],
                                height: 30,
                              ),
                            ),
                            SizedBox(
                              width: 22,
                            ),
                            Container(
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.purple, width: 1),
                              ),
                              child: SvgPicture.asset(
                                "assets/AAAA/google-plus.svg",
                                color: Colors.purple[400],
                                height: 30,
                              ),
                            ),
                            SizedBox(
                              width: 22,
                            ),
                            Container(
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.purple, width: 1),
                              ),
                              child: SvgPicture.asset(
                                "assets/AAAA/twitter.svg",
                                color: Colors.purple[400],
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
