import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_app1/pages/ressources/dimensions/constants.dart';
import 'package:my_app1/pages/worker/pending_requests.dart';
import 'package:my_app1/pages/worker/worker_confirmed_requests.dart';
import 'package:my_app1/pages/worker/worker_processing_requests.dart';
import 'package:my_app1/pages/worker/worker_refused_requests.dart';
import 'package:my_app1/services/LocalNotificationApi.dart';

import '../../services/AuthServices.dart';

class WorkerRequests extends StatefulWidget {
  const WorkerRequests({Key? key}) : super(key: key);

  @override
  State<WorkerRequests> createState() => _WorkerRequestsState();
}

class _WorkerRequestsState extends State<WorkerRequests> with TickerProviderStateMixin {
  late TabController _tabController;
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {});
      });
    FirebaseMessaging.instance.getToken().then((userToken) {});
    FirebaseMessaging.onMessage.listen((event) {
      NotificationConfig().showNotification(event.notification!.title!, event.notification!.body!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
            child: Container(
              alignment: Alignment.center,
              child: TabBar(
                isScrollable: true,
                unselectedLabelStyle: TextStyle(color: Colors.purple),
                indicatorColor: Colors.purple,
                unselectedLabelColor: Colors.purple,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.purple),
                controller: _tabController,
                labelColor: Colors.white,
                tabs: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Constants.screenHeight * 0.009,
                    ),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Refusé",
                        style: TextStyle(
                          fontSize: Constants.screenHeight * 0.015,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Constants.screenHeight * 0.009,
                    ),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "En attente",
                        style: TextStyle(
                          fontSize: Constants.screenHeight * 0.015,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Constants.screenHeight * 0.009,
                    ),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "En cours",
                        style: TextStyle(
                          fontSize: Constants.screenHeight * 0.015,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Constants.screenHeight * 0.009,
                    ),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Terminés",
                        style: TextStyle(
                          fontSize: Constants.screenHeight * 0.015,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  WorkerRefusedRequests(),
                  WorkerPendingRequests(),
                  WorkerProcessingRequests(),
                  WorkerConfirmedRequests(),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
