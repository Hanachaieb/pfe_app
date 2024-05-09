import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app1/pages/client/client_requests.dart';
import 'package:my_app1/pages/worker/messages/Messages.dart';
import 'package:my_app1/services/LocalNotificationApi.dart';

class HomeScreenClient extends StatefulWidget {
  const HomeScreenClient({Key? key}) : super(key: key);

  @override
  State<HomeScreenClient> createState() => _HomeScreenWorkerState();
}

class _HomeScreenWorkerState extends State<HomeScreenClient> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getToken().then((userToken) {});
    FirebaseMessaging.onMessage.listen((event) {
      print(event.data);
      NotificationConfig().showNotification(event.notification!.title!, event.notification!.body!);
    });
  }

  Widget positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: Text(
            "Oui",
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget negative() {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Non",
          style: TextStyle(color: Colors.blueAccent),
        ));
  }

  Future<bool> avoidRteurnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Vous etes sure de sortir"),
            actions: [
              negative(),
              positive(),
            ],
          );
        });
    return true;
  }

  int currentPage = 0;
  List<Widget> pages = [ClientRequests(), buildMessages()];
  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: avoidRteurnButton,
        child: Scaffold(
          body: pages[currentPage],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.purple,
            showSelectedLabels: true,
            currentIndex: currentPage,
            selectedLabelStyle: TextStyle(color: Colors.purple),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
              BottomNavigationBarItem(icon: Icon(Icons.message_rounded), label: "Messages"),
            ],
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
            },
          ),
        ));
  }
}
