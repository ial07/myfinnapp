import 'dart:convert';

import 'package:flutter/cupertino.dart';

ChangePassModel changePassModelFromJson(String str) =>
    ChangePassModel.fromJson(json.decode(str));

String changePassModelToJson(ChangePassModel data) =>
    json.encode(data.toJson());

class ChangePassModel {
  ChangePassModel({
    this.id,
    this.passwordold,
    this.passwordnew,
  });

  int id;
  String passwordold;
  String passwordnew;

  factory ChangePassModel.fromJson(Map<String, dynamic> json) =>
      ChangePassModel(
          id: json["id"],
          passwordnew: json["passwordnew"],
          passwordold: json["passwordold"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "passwordnew": passwordnew, "passwordold": passwordold};
}
