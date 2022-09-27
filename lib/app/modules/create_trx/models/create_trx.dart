import 'dart:convert';

import 'package:flutter/cupertino.dart';

CreateTRXModel createTRXModelFromJson(String str) =>
    CreateTRXModel.fromJson(json.decode(str));

String createTRXModelToJson(CreateTRXModel data) => json.encode(data.toJson());

class CreateTRXModel {
  CreateTRXModel({
    this.bankaccountid,
    this.Amount,
    this.Notes,
  });

  int bankaccountid;
  double Amount;
  String Notes;

  factory CreateTRXModel.fromJson(Map<String, dynamic> json) => CreateTRXModel(
        bankaccountid: json["bankaccountid"],
        Amount: json["Amount"],
        Notes: json["Notes"],
      );

  Map<String, dynamic> toJson() => {
        "bankaccountid": bankaccountid,
        "Amount": Amount,
        "Notes": Notes,
      };
}
