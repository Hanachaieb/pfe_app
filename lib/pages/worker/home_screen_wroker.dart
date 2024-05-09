import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app1/pages/worker/messages/Messages.dart';
import 'package:my_app1/pages/worker/worker_requests.dart';

class HomeScreenWorker extends StatefulWidget {
  const HomeScreenWorker({Key? key}) : super(key: key);

  @override
  State<HomeScreenWorker> createState() => _HomeScreenWorkerState();
}

class _HomeScreenWorkerState extends State<HomeScreenWorker> {
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
  List<Widget> pages = [WorkerRequests(), buildMessages()];
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
