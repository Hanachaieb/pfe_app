import 'package:flutter/material.dart';
import 'package:my_app1/pages/acceuil.dart';
import 'package:my_app1/pages/apropos.dart';
import 'package:my_app1/pages/comptet.dart';
import 'package:my_app1/pages/contacter.dart';
import 'package:my_app1/pages/login.dart'; // Assuming login.dart defines LoginPage
import 'package:my_app1/pages/logint.dart';
import 'package:my_app1/pages/resultat.dart';
import 'package:my_app1/pages/signup.dart';
import 'package:my_app1/pages/signupt.dart';
import 'package:my_app1/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/welcome",
      routes: {
        "/welcome": (context) => const Welcome(),
        "/login": (context) => const Login(),
        "/signup": (context) => const Signup(),
        "/acceuil": (context) => Acceuil(),
        "/resultat": (context) => Resultat(),
        "/contacter": (context) => const Contacter(),
        "/logint": (context) => const Logint(),
        "/signupt": (context) => const Signupt(),
        "/comptet": (context) => const Comptet(),
        "/apropos": (context) => const Apropos(),
      },
    );
  }
}
