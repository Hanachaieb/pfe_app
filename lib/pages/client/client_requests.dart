import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app1/pages/client/client_finished_requests.dart';
import 'package:my_app1/pages/client/client_processing_requests.dart';
import 'package:my_app1/pages/client/client_refused_requests.dart';
import 'package:my_app1/pages/client/client_search_screen.dart';
import 'package:my_app1/pages/ressources/dimensions/constants.dart';

import '../../services/AuthServices.dart';
import 'client_pending_requests.dart';

class ClientRequests extends StatefulWidget {
  const ClientRequests({Key? key}) : super(key: key);

  @override
  State<ClientRequests> createState() => _WorkerRequestsState();
}

class _WorkerRequestsState extends State<ClientRequests> with TickerProviderStateMixin {
  late TabController _tabController;
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {});
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
        actions: [
          IconButton(
              onPressed: () {
                Get.to(ClientSearchScreen());
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
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
                  ClientRefusedRequests(),
                  ClientPendingRequests(),
                  ClientProcessingRequests(),
                  ClientConfirmedRequests(),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
