import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../ressources/router/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var seen = GetStorage().read("seen");
  var role = GetStorage().read("role");
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      if (role != null) {
        if (role == 'Client') {
          Get.toNamed(AppRouting.HomeClient);
        } else {
          Get.toNamed(AppRouting.HomeWorker);
        }
      } else {
        Get.toNamed(AppRouting.signIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(
        color: Colors.purple[800],
      ),
    ));
  }
}
