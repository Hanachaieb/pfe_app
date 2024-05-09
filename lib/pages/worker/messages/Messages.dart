import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_app1/models/Cusers.dart';
import 'package:my_app1/pages/ressources/dimensions/constants.dart';
import 'package:my_app1/services/AuthServices.dart';

import 'Messenger.dart';

class buildMessages extends StatefulWidget {
  @override
  _buildMessagesState createState() => _buildMessagesState();
}

class _buildMessagesState extends State<buildMessages> {
  var user = GetStorage().read("user");
  ScrollController controller = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                  Navigator.pushNamed(context, "/contact_us");
                },
              ),
              ListTile(
                title: Text("A propos Nous"),
                leading: Icon(Icons.help_center),
                onTap: () {
                  Navigator.pushNamed(context, "/about_us");
                },
              ),
              ListTile(
                title: Text("Déconnecter"),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Êtes-vous sure de déconnecter ?"),
                          actions: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.redAccent.withOpacity(0.5), borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Non"))),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blueAccent,
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      AuthServices().logOut(context);
                                    },
                                    child: Text(
                                      "Oui",
                                      style: TextStyle(color: Colors.white),
                                    ))),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            "Messages",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: snapshotMessages.collection('messages').orderBy('time').snapshots(),
                builder: (context, snapshot) {
                  List msg = [];

                  if (snapshot.hasData) {
                    if (snapshot.data!.size != 0) {
                      final messages = snapshot.data!.docs.reversed;

                      for (var message in messages) {
                        final getText = message.get('text');
                        final getSender = message.get('sender');
                        final getDestination = message.get('destination');
                        final getTime = message.get('time');
                        final Map<String, String> messageWidget = {
                          'getText': getText,
                          'getTime': DateFormat('kk:mm').format(DateTime.parse(getTime.toDate().toString())),
                          'getSender': getSender,
                          'getDestination': getDestination,
                        };
                        if ((((messageWidget["getSender"] == user['uid']) || (messageWidget["getDestination"] == user['uid'])))) {
                          msg.add(messageWidget);
                        }
                      }

                      for (int i = 0; i < msg.length; i++) {
                        for (int j = i + 1; j < msg.length; j++) {
                          if ((msg[i]["getSender"] == msg[j]["getSender"]) &&
                                  (msg[i]["getDestination"] == msg[j]["getDestination"]) ||
                              (msg[i]["getSender"] == msg[j]["getDestination"]) &&
                                  (msg[i]["getSender"] == msg[j]["getDestination"])) {
                            msg[j] = {
                              'getText': '',
                              'getSender': '',
                              'getDestination': '',
                            };
                          }
                        }
                      }

                      for (int i = 0; i < msg.length; i++) {
                        if (msg[i]["getSender"] == "") {
                          msg.remove(msg[i]);
                          i--;
                        }
                      }
                      if (msg.isNotEmpty) {
                        return Column(
                          children: [
                            Expanded(
                                child: ListView.builder(
                              itemCount: msg.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.purple.withOpacity(0.2), borderRadius: BorderRadius.circular(5)),
                                    child: InkWell(
                                      onTap: () async {
                                        var destination = await FirebaseFirestore.instance
                                            .collection("users")
                                            .where(
                                              "uid",
                                              isEqualTo: this.user['uid'] == msg[index]["getDestination"]
                                                  ? "${msg[index]["getSender"]}"
                                                  : "${msg[index]["getDestination"]}",
                                            )
                                            .get();
                                        var user =
                                            Cusers.fromJson(destination.docs.toList().first.data() as Map<String, dynamic>);

                                        Get.to(Messenger(
                                          user: user,
                                        ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: msg[index]['getSender'] == user['uid']
                                                ? FirebaseFirestore.instance
                                                    .collection("users")
                                                    .where('uid', isEqualTo: msg[index]["getDestination"])
                                                    .snapshots()
                                                : FirebaseFirestore.instance
                                                    .collection("users")
                                                    .where('uid', isEqualTo: msg[index]["getSender"])
                                                    .snapshots(),
                                            builder: (BuildContext context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Row(
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 33, backgroundImage: AssetImage("assets/images/profile.png")),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              "${snapshot.data!.docs[0].get('fullName')}",
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    "${msg[index]['getSender'] == user['uid'] ? 'Vous ' : ''} ${msg[index]["getText"]}",
                                                                    overflow: TextOverflow.ellipsis,
                                                                    maxLines: 1,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Text("${msg[index]["getTime"]}"),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              } else {
                                                return Center(child: CircularProgressIndicator());
                                              }
                                            }),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              padding: EdgeInsets.all(20),
                              controller: controller,
                            )),
                          ],
                        );
                      } else {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/message.png',
                                height: Constants.screenHeight * 0.1,
                              ),
                              Text("Pas des messages encore.")
                            ],
                          ),
                        );
                      }
                    } else
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/message.png',
                              height: Constants.screenHeight * 0.1,
                            ),
                            Text("Pas des messages encore.")
                          ],
                        ),
                      );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
