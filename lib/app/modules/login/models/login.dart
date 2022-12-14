import 'dart:convert';

import 'package:flutter/cupertino.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.username,
    this.password,
  });

  String username;
  String password;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(username: json["username"], password: json["password"]);

  Map<String, dynamic> toJson() => {"username": username, "password": password};
}
