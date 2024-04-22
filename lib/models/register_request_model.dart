import 'dart:convert';

class RegisterRequestModel {
  final String email;
  final String password;

  RegisterRequestModel({
    required this.email,
    required this.password,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    return RegisterRequestModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    return _data;
  }

  void registerUser() {
    // Assuming you have a way to get user input (e.g., from a form)
    final email = 'user@example.com'; // Replace with user input
    final password = 'secure_password'; // Replace with user input

    final registerRequestModel = RegisterRequestModel(
      email: email,
      password: password,
    );

    // Use the registerRequestModel instance here, e.g., for API calls
    // You'll need to implement the logic for making the API call
  }
}
