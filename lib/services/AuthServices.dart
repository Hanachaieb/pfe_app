import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:my_app1/models/Cusers.dart';

class AuthServices {
  var storage = GetStorage();
  final FirebaseAuth auth = FirebaseAuth.instance;
  var userCollection = FirebaseFirestore.instance.collection('users');
  sendNotfiy(String title, String body, String token) async {
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          "Content-Type": 'application/json',
          'Authorization':
              'key=	AAAAufj_w68:APA91bGMssFQpOs1nqgIWQStfXeIBhMsZ2CwLvE5wlvANuh2j5eCQy7P72d2pPSDmDkpNE-uQ0qf4YG5DVbZR2oPBmQxQqIK5KPvnJufM01h9uK_W4Xuz0BLm9DRW9vJROtyI4fDCAVQ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{"body": body.toString(), 'title': title.toString()},
            "priority": "high",
            "data": <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            },
            'to': token
          },
        ));
  }

  Future<bool> signIn(String emailController, String passwordController) async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      await auth.signInWithEmailAndPassword(email: emailController, password: passwordController);
      userCollection.doc(user!.uid).update({"token": token});
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> signUp(
      {required String emailController,
      required String passwordController,
      required String fullName,
      required String role,
      String? GsmController,
      String? occupation,
      String? facebook,
      String? adresse,
      String? desc}) async {
    String? token = await FirebaseMessaging.instance.getToken();

    try {
      await auth.createUserWithEmailAndPassword(email: emailController, password: passwordController);

      await saveUser(Cusers(
          uid: user!.uid,
          fullName: fullName,
          email: emailController,
          role: role,
          gsm: GsmController,
          token: token,
          desc: desc,
          adresse: adresse,
          facebook: facebook,
          occupation: occupation));

      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetPassword(String emailController) async {
    try {
      await auth.sendPasswordResetEmail(email: emailController);
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  Future<Cusers> getUserData() async {
    var userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    return Cusers.fromJson(userData.data()!);
  }

  User? get user => auth.currentUser; //pour recuperer l'utilisateur courant

  saveUser(Cusers user) async {
    try {
      await userCollection.doc(user.uid).set(user.toJson());
    } catch (e) {}
  }

  saveUserLocally(Cusers user) {
    storage.write("role", user.role);

    storage.write("user", {
      'uid': user.uid,
      'fullName': user.fullName,
      'email': user.email,
      'gsm': user.gsm,
      'role': user.role,
    });
  }

  logOut(BuildContext context) {
    storage.remove('role');
    storage.remove('user');
    Navigator.of(context).pushNamedAndRemoveUntil('/sign_in', (Route<dynamic> route) => false);
  }

  Future<String> changeEmail(String email, String password) async {
    var userFromStorage = GetStorage().read('user');
    try {
      await auth.signInWithEmailAndPassword(email: userFromStorage['email'], password: password);
      await user!.updateEmail(email);
      await userCollection.doc(userFromStorage['uid']).update({'email': email});

      userFromStorage['email'] = email;
      await GetStorage().write('user', userFromStorage);
      return 'done';
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        return "Email deja utilisé";
      } else {
        return "Mot de passe incorrecte";
      }
    }
  }

  Future<bool> changePassword(String password, String newPassword) async {
    var userFromStorage = GetStorage().read('user');

    try {
      await auth.signInWithEmailAndPassword(email: userFromStorage['email'], password: password);
      await user!.updatePassword(newPassword);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
