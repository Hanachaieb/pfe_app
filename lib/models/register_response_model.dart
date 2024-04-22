import 'dart:convert';

RegisterResponseModel loginResponseModel(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  final String message;
  final bool success; // Assuming the API response includes a success field

  RegisterResponseModel({
    required this.message,
    required this.success,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      message: json['message'],
      success:
          json['success'] ?? false, // Handle potential absence of 'success'
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['success'] = success;
    return _data;
  }
}
