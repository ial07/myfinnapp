import 'dart:convert';

import 'package:flutter/cupertino.dart';

CreateAccountModel createAccountModelFromJson(String str) =>
    CreateAccountModel.fromJson(json.decode(str));

String createAccountModelToJson(CreateAccountModel data) =>
    json.encode(data.toJson());

class CreateAccountModel {
  CreateAccountModel({
    this.accountname,
  });

  String accountname;

  factory CreateAccountModel.fromJson(Map<String, dynamic> json) =>
      CreateAccountModel(
        accountname: json["accountname"],
      );

  Map<String, dynamic> toJson() => {"accountname": accountname};
}
