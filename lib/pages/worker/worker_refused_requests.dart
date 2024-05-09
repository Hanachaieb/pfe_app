import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_app1/pages/ressources/dimensions/constants.dart';

import '../../models/Request.dart';

class WorkerRefusedRequests extends StatefulWidget {
  const WorkerRefusedRequests({Key? key}) : super(key: key);

  @override
  State<WorkerRefusedRequests> createState() => _WorkerRefusedRequestsState();
}

class _WorkerRefusedRequestsState extends State<WorkerRefusedRequests> {
  @override
  var user = GetStorage().read("user");
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('requests')
            .where("workerId", isEqualTo: user['uid'])
            .where("status", isEqualTo: -1)
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
                        child: Text("Pas des demandes refusé pour le moment "),
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
                                            FirebaseFirestore.instance.collection("users").doc(users[index].userId).snapshots(),
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
                                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                                              onPressed: () async {
                                                                await FirebaseFirestore.instance
                                                                    .collection("requests")
                                                                    .doc(users[index].id)
                                                                    .update({"status": 1});
                                                                Fluttertoast.showToast(
                                                                    msg: "Demande Accepté",
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    gravity: ToastGravity.BOTTOM,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Colors.green,
                                                                    textColor: Colors.white,
                                                                    fontSize: 16.0);
                                                              },
                                                              child: Text(
                                                                "Accepter",
                                                                style: TextStyle(color: Colors.white),
                                                              )),
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
