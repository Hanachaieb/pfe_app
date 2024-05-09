import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app1/config.dart';
import 'package:my_app1/models/register_request_model.dart';

import '../models/login_request_model.dart';

class APIService {
  static final http.Client client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    final Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    final Uri url = Uri.https(Config.apiURL, Config.loginAPI);

    final http.Response response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      //SHARED
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> register(RegisterRequestModel model) async {
    final Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    final Uri url = Uri.https(Config.apiURL, Config.registerAPI);

    final http.Response response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      // Traiter la réponse de l'enregistrement
      return true;
    } else {
      return false;
    }
  }
}
