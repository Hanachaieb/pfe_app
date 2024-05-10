import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_app1/models/Request.dart';
import 'package:my_app1/pages/ressources/dimensions/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientPendingRequests extends StatefulWidget {
  const ClientPendingRequests({Key? key}) : super(key: key);

  @override
  State<ClientPendingRequests> createState() => _ClientRequestsState();
}

class _ClientRequestsState extends State<ClientPendingRequests> {
  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('requests')
            .where("userId", isEqualTo: user['uid'])
            .where("status", isEqualTo: 0)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Request> users = [];
            for (var data in snapshot.data!.docs.toList()) {
              users.add(Request.fromJson(data.data() as Map<String, dynamic>));
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
                        child: Text("Pas des demandes en attente pour le moment "),
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: StreamBuilder(
                                        stream:
                                            FirebaseFirestore.instance.collection("users").doc(users[index].workerId).snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                                          if (snapshot.hasData) {
                                            return Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                                height: Constants.screenHeight * 0.05,
                                                                child: Image.asset("assets/images/profile.png")),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text("Nom et prénom :${snapshot.data!.get("fullName")}"),
                                                              Text("Profession : ${snapshot.data!.get("occupation")}"),
                                                              Text("Email : ${snapshot.data!.get("email")}"),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(
                                                            "Date de demande :${DateFormat('yyyy-MM-dd hh:mm').format(users[index].date)} "),
                                                      ),
                                                      Row(
                                                        children: [
                                                          ElevatedButton(
                                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                              onPressed: () async {
                                                                await FirebaseFirestore.instance
                                                                    .collection("requests")
                                                                    .doc(users[index].id)
                                                                    .delete();
                                                                Get.snackbar("", "",
                                                                    titleText: Text(
                                                                      "Connect Services",
                                                                      style: TextStyle(color: Colors.white),
                                                                    ),
                                                                    messageText: Text(
                                                                      "Demande Supprimé",
                                                                      style: TextStyle(color: Colors.white),
                                                                    ),
                                                                    icon: Icon(Icons.settings, color: Colors.white),
                                                                    snackPosition: SnackPosition.BOTTOM,
                                                                    backgroundColor: Colors.red);
                                                              },
                                                              child: Text(
                                                                "Supprimer",
                                                                style: TextStyle(color: Colors.white),
                                                              )),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: ElevatedButton(
                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                                                onPressed: () async {
                                                                  final call = Uri.parse('tel:${snapshot.data!.get("gsm")}');
                                                                  if (await canLaunchUrl(call)) {
                                                                    launchUrl(call);
                                                                  } else {
                                                                    throw 'Could not launch $call';
                                                                  }
                                                                },
                                                                child: Text(
                                                                  "Appeler",
                                                                  style: TextStyle(color: Colors.white),
                                                                )),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
    );
  }
}
