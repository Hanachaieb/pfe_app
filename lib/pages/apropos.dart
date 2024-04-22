import 'package:flutter/material.dart';

class Apropos extends StatelessWidget {
  const Apropos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("À propos nous"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 22,
                ),
                Text(
                  "Connect Service",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: "myfont"), // Augmentez la taille ici
                ),
                SizedBox(
                  height: 17,
                ),
                Image.asset(
                  "C:/pfe/my_app1/assets/AAAA/WhatsApp Image 2024-03-28 à 14.00.58_f17e3914.jpg",
                  width: 350,
                ),
                SizedBox(
                  height: 17,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      color: Colors.transparent, // Couleur transparente
                      child: Text(
                        "Nous vous présentons notre solution aux défis rencontrés par les travailleurs indépendants et les clients dans le domaine des services. Notre application mobile vise à résoudre les difficultés auxquelles sont confrontés les travailleurs indépendants pour se faire connaître et trouver des clients, en raison de la pression concurrentielle, du manque de présence en ligne, des limitations en matière de communication et d'une promotion insuffisante. De plus, nous aidons les clients à trouver des travailleurs indépendants qualifiés malgré des emplois du temps chargés et une planification de projets à long terme, souvent source de retards et compliquant les recherches rapides. Notre solution est une application conviviale et efficace qui simplifie la communication entre les clients et les travailleurs indépendants, offrant une expérience fluide pour toutes les parties impliquées.",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 14), // Augmentez la taille ici
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 22), // Ajout d'un espace en bas
                // Other widgets can be added here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
