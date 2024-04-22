import 'dart:convert';

import 'package:my_app1/models/register_response_model.dart';
LoginResponseModel loginResponseModel(String str) =>
LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel ({
  required this.message,
    required this.data,
});
late final String message;
late final Data data;



   LoginResponseModel.fromJson(Map<String, dynamic> json) {
      message = json['message'];
      data = Data.fromJson(json['data'] );
    
  }

  Map<String, dynamic> toJson() {
    final _data =<String, dynamic>{};
    _data['message']=message;
        _data['data']=data.toJson();
        return _data

  }
}

class Data {
  final String email;
  final String date;
  final String id;
  final String token;

  Data({
    required this.email,
    required this.date,
    required this.id,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      email: json['email'] as String,
      date: json['date'] as String,
      id: json['id'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'date': date,
      'id': id,
      'token': token,
    };
  }
}
