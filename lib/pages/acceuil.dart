// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({Key? key}) : super(key: key);

  @override
  _AcceuilState createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  String? selectedWorker;
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text("Contacter Nous"),
                leading: Icon(Icons.perm_phone_msg),
                onTap: () {
                  Navigator.pushNamed(context, "/contacter");
                },
              ),
              ListTile(
                title: Text("A propos Nous"),
                leading: Icon(Icons.help_center),
                onTap: () {
                  Navigator.pushNamed(context, "/apropos");
                },
              ),
              ListTile(
                title: Text("Déconnecter"),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pushNamed(context, "/login");
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            "Accueil",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/WhatsApp Image 2024-03-18 à 14.14.33_c58036ff.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.purple[100]?.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      margin: EdgeInsets.all(10),
                      child: DropdownButton<String>(
                        hint: Text(
                          'Travailleur Indépendant...',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.purple[800],
                          ),
                        ),
                        value: selectedWorker,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedWorker = newValue;
                          });
                        },
                        items: <String>[
                          'Plombier',
                          'Électricien',
                          'Ouvrier de bâtiment',
                          'Peintre',
                          'Femme de ménage',
                          'Baby-sitter',
                          'Menuisier',
                          'Technicien en climatisation',
                          'Forgeron',
                          'Jardinier',
                          'Autres',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.purple[100]?.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      margin: EdgeInsets.all(10),
                      child: DropdownButton<String>(
                        hint: Text(
                          'Votre Ville...',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.purple[800],
                          ),
                        ),
                        value: selectedCity,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCity = newValue;
                          });
                        },
                        items: <String>[
                          'Tunis',
                          'Gabes',
                          'Mahdia',
                          'Kébili',
                          'Mounastir',
                          'Sousse',
                          'Ariana',
                          'Béja',
                          'Ben Arous',
                          'Bizerte',
                          'Jendouba',
                          'Médenine',
                          'Manouba',
                          'Nabeul',
                          'Gafsa',
                          'Sfax',
                          'Sidi Bouzid',
                          'Siliana',
                          'Tatouine',
                          'Tozeur',
                          'Zaghouan',
                          'El Kef',
                          'Kasserine',
                          'Kairouan'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (selectedWorker == null || selectedCity == null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Erreur"),
                            content: Text(
                              "Veuillez sélectionner à la fois un travailleur indépendant et une ville.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.popAndPushNamed(context, "/resultat");
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 106.0, vertical: 10.0),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "Trouver",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
