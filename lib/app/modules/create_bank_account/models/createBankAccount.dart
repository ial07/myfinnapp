import 'dart:convert';

import 'package:flutter/cupertino.dart';

CreateBankAccountModel createBankAccountModelFromJson(String str) =>
    CreateBankAccountModel.fromJson(json.decode(str));

String createBankAccountModelToJson(CreateBankAccountModel data) =>
    json.encode(data.toJson());

class CreateBankAccountModel {
  CreateBankAccountModel({
    this.UserAccountId,
    this.AccountIdOwner,
    this.BankCode,
    this.Amount,
    this.Notes,
    this.ExpiredDate,
    this.IsDebit,
  });

  int UserAccountId;
  int AccountIdOwner;
  String BankCode;
  double Amount;
  String Notes;
  String ExpiredDate;
  bool IsDebit;

  factory CreateBankAccountModel.fromJson(Map<String, dynamic> json) =>
      CreateBankAccountModel(
        UserAccountId: json["UserAccountId"],
        AccountIdOwner: json["AccountIdOwner"],
        BankCode: json["BankCode"],
        Amount: json["Amount"],
        Notes: json["Notes"],
        ExpiredDate: json["ExpiredDate"],
        IsDebit: json["IsDebit"],
      );

  Map<String, dynamic> toJson() => {
        "UserAccountId": UserAccountId,
        "AccountIdOwner": AccountIdOwner,
        "BankCode": BankCode,
        "Amount": Amount,
        "Notes": Notes,
        "ExpiredDate": IsDebit ? ExpiredDate + "Z" : ExpiredDate,
        "IsDebit": IsDebit,
      };
}
