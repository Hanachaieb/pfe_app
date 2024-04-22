import 'package:flutter/material.dart';

class Comptet extends StatelessWidget {
  const Comptet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("compte"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
        actions: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "8",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10), // Espacement entre l'AppBar et le texte "Nom :"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.purple,
                ),
                SizedBox(
                    width: 10), // Espacement entre l'icône et le texte "Nom :"
                Text(
                  "Nom :",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 35), // Espacement entre l'AppBar et le texte "Nom :"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.work,
                  color: Colors.purple,
                ),
                SizedBox(
                    width:
                        10), // Espacement entre l'icône et le texte "Profession :"
                Text(
                  "Profession:",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 35), // Espacement entre l'AppBar et le texte "Nom :"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.purple,
                ),
                SizedBox(
                    width:
                        10), // Espacement entre l'icône et le texte "Localisation :"
                Text(
                  "Localisation :",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 35), // Espacement entre l'AppBar et le texte "Nom :"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.purple,
                ),
                SizedBox(
                    width:
                        10), // Espacement entre l'icône et le texte "Num tél :"
                Text(
                  "Num tél :",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          // Ajoutez ici le reste du contenu de votre page
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Modification"),
              leading: Icon(Icons.settings),
              onTap: () {},
            ),
            ListTile(
              title: Text("Contacter nous"),
              leading: Icon(Icons.perm_phone_msg),
              onTap: () {
                Navigator.pushNamed(context, "/contacter");
              },
            ),
            ListTile(
              title: Text("A propos nous "),
              leading: Icon(Icons.help_center),
              onTap: () {
                Navigator.pushNamed(context, "/apropos");
              },
            ),
            ListTile(
              title: Text("Déconnecté"),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pushNamed(context, "/logint");
              },
            ),
          ],
        ),
      ),
    );
  }
}
