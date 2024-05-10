import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app1/models/Cusers.dart';
import 'package:my_app1/pages/ressources/dimensions/constants.dart';
import 'package:my_app1/pages/worker/messages/Messenger.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientSearchScreen extends StatefulWidget {
  const ClientSearchScreen({Key? key}) : super(key: key);

  @override
  State<ClientSearchScreen> createState() => _ClientSearchScreenState();
}

class _ClientSearchScreenState extends State<ClientSearchScreen> {
  var user = GetStorage().read("user");
  String? profession;
  String? adresse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          SizedBox(height: 12),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 225, 190, 231).withOpacity(0.8),
              borderRadius: BorderRadius.circular(40),
            ),
            margin: EdgeInsets.all(10),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.work,
                  color: Colors.purple[800],
                ),
                hintText: 'Profession',
                hintStyle: TextStyle(
                  fontSize: 18.0,
                  color: const Color.fromARGB(255, 109, 101, 115),
                ),
                border: InputBorder.none, // Supprime la bordure
              ),
              value: profession,
              items: <String>[
                'Plomberie',
                'Électricien',
                'Ouvrier de batiment',
                'Peintre',
                'Femme de ménage ',
                'Baby-sitter',
                'Menuiserie',
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
              onChanged: (String? newValue) {
                setState(() {
                  profession = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez sélectionner votre profession';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 225, 190, 231).withOpacity(0.8),
              borderRadius: BorderRadius.circular(40),
            ),
            margin: EdgeInsets.all(10),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.location_city,
                  color: Colors.purple[800],
                ),
                hintText: 'Votre Ville',
                hintStyle: TextStyle(
                  fontSize: 18.0,
                  color: const Color.fromARGB(255, 109, 101, 115),
                ),
                border: InputBorder.none,
              ),
              value: adresse,
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
                'Kairouan',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  adresse = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez sélectionner votre ville';
                }
                return null;
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where("role", isEqualTo: 'Travailleur')
                  .where("occupation", isEqualTo: profession)
                  .where("adresse", isEqualTo: adresse)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Cusers> users = [];
                  for (var data in snapshot.data!.docs.toList()) {
                    users.add(Cusers.fromJson(data.data() as Map<String, dynamic>));
                  }
                  print(snapshot.data!.docs.toList());
                  if (users.isEmpty) {
                    return Center(
                      child: Container(
                        height: Constants.screenHeight * 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Pas des travailleur pour le moment "),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Slidable(
                                key: const ValueKey(0),
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      icon: Icons.close,
                                      label: 'Fermer',
                                      onPressed: (BuildContext ctx) {},
                                    ),
                                    SlidableAction(
                                        onPressed: (BuildContext ctx) async {
                                          final call = Uri.parse('tel:${users[index].gsm}');
                                          if (await canLaunchUrl(call)) {
                                            launchUrl(call);
                                          } else {
                                            throw 'Could not launch $call';
                                          }
                                        },
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        icon: Icons.call,
                                        label: "Appeler"),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      icon: Icons.close,
                                      label: 'Fermer',
                                      onPressed: (BuildContext ctx) {},
                                    ),
                                    SlidableAction(
                                        onPressed: (BuildContext ctx) async {
                                          Get.to(Messenger(
                                            user: users[index],
                                          ));
                                        },
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        icon: Icons.message_rounded,
                                        label: "Message"),
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.purple.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                height: Constants.screenHeight * 0.05,
                                                child: Image.asset("assets/images/profile.png")),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Nom et prenom :${users[index].fullName} "),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("profession : ${users[index].occupation}"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Ville : ${users[index].adresse}"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: Constants.screenWidth,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                                              onPressed: () async {
                                                var instance = FirebaseFirestore.instance.collection('requests');
                                                var doc = instance.doc();
                                                instance.doc(doc.id).set({
                                                  "userId": user['uid'],
                                                  "workerId": users[index].uid,
                                                  "date": DateTime.now(),
                                                  "status": 0,
                                                });
                                                instance.doc(doc.id).update({"id": doc.id});
                                                Get.snackbar("", "",
                                                    titleText: Text(
                                                      "Connect Services",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    messageText: Text(
                                                      "Demande Ajouté",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    icon: Icon(Icons.settings, color: Colors.white),
                                                    snackPosition: SnackPosition.BOTTOM,
                                                    backgroundColor: Colors.green);
                                              },
                                              child: Text(
                                                "Ajouter une demande",
                                                style: TextStyle(color: Colors.white),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
