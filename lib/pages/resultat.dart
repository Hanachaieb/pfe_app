// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Resultat extends StatelessWidget {
  const Resultat({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            'Résultat Trouver', // Updated text with white color
            style: TextStyle(
              color: Colors.white, // Set text color to white
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Résultats De La Recherche :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30.0), // Add space between text and search bar
            // ListView.builder integrated here
            Expanded(
              // Ensuring ListView takes up remaining space
              child: Scrollbar(
                child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      // on tap hethi bch ki nadhghat ala lphoto yekhdem l code li mabin {}
                      onTap: () {},
                      child: GridTile(
                        child: Container(
                          color: Colors.amber, // Example background color
                          margin: EdgeInsets.symmetric(vertical: 8),
                          height: 200, // Set height for the container
                          child: Center(
                            child: Text(
                              'Item $index', // Example content
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
