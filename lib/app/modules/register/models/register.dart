import 'dart:convert';

import 'package:flutter/cupertino.dart';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.username,
    this.email,
    this.telephone,
    this.photo,
    this.password,
  });

  String username;
  String password;
  String telephone;
  String photo;
  String email;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
      username: json["username"],
      password: json["password"],
      email: json["email"],
      telephone: json["telephone"],
      photo: json["photo"]);

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        "telephone": telephone,
        "photo": photo
      };
}
