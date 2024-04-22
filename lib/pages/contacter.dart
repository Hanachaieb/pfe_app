import 'package:flutter/material.dart';

class Contacter extends StatelessWidget {
  const Contacter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Contacter nous"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.purple,
                ),
                SizedBox(width: 10),
                Text(
                  "Téléphone :",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 35),
            Row(
              children: [
                Icon(
                  Icons.mail,
                  color: Colors.purple,
                ),
                SizedBox(width: 10),
                Text(
                  "Mail :",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 35),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.purple,
                ),
                SizedBox(width: 10),
                Text(
                  "Localisation :",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 35),
            Row(
              children: [
                Icon(
                  Icons.message,
                  color: Colors.purple,
                ),
                SizedBox(width: 10),
                Text(
                  "Message :",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 35),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Écrivez votre message ici...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action à effectuer lorsque le bouton est pressé
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 178, 104, 193)),
                  ),
                  child: Text("Envoyer"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
