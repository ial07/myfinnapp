// To parse this JSON data, do
//
//     final accountBankList = accountBankListFromJson(jsonString);

import 'dart:convert';

import 'package:myfinnapp/app/modules/create_bank_account/models/getBank.dart';

AccountBankList accountBankListFromJson(String str) =>
    AccountBankList.fromJson(json.decode(str));

String accountBankListToJson(AccountBankList data) =>
    json.encode(data.toJson());

class AccountBankList {
  AccountBankList({
    this.meta,
    this.data,
  });

  Meta meta;
  List<BankList> data;

  factory AccountBankList.fromJson(Map<String, dynamic> json) =>
      AccountBankList(
        meta: Meta.fromJson(json["meta"]),
        data:
            List<BankList>.from(json["data"].map((x) => BankList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Transaction {
  Transaction({
    this.id,
    this.bankAccountId,
    this.bankAccount,
    this.amount,
    this.notes,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.deletedBy,
    this.deletedDate,
  });

  int id;
  int bankAccountId;
  BankList bankAccount;
  int amount;
  String notes;
  CreatedBy createdBy;
  DateTime createdDate;
  String updatedBy;
  DateTime updatedDate;
  String deletedBy;
  DateTime deletedDate;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["Id"],
        bankAccountId: json["BankAccountId"],
        bankAccount: BankList.fromJson(json["BankAccount"]),
        amount: json["Amount"],
        notes: json["Notes"],
        createdBy: createdByValues.map[json["CreatedBy"]],
        createdDate: DateTime.parse(json["CreatedDate"]),
        updatedBy: json["UpdatedBy"],
        updatedDate: DateTime.parse(json["UpdatedDate"]),
        deletedBy: json["DeletedBy"],
        deletedDate: DateTime.parse(json["DeletedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "BankAccountId": bankAccountId,
        "BankAccount": bankAccount.toJson(),
        "Amount": amount,
        "Notes": notes,
        "CreatedBy": createdByValues.reverse[createdBy],
        "CreatedDate": createdDate.toIso8601String(),
        "UpdatedBy": updatedBy,
        "UpdatedDate": updatedDate.toIso8601String(),
        "DeletedBy": deletedBy,
        "DeletedDate": deletedDate.toIso8601String(),
      };
}

class BankList {
  BankList({
    this.id,
    this.userAccountId,
    this.userAccount,
    this.accountIdOwner,
    this.bankCode,
    this.bank,
    this.amount,
    this.notes,
    this.isDebit,
    this.transactions,
    this.expiredDate,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.deletedBy,
    this.deletedDate,
  });

  int id;
  int userAccountId;
  UserAccount userAccount;
  int accountIdOwner;
  String bankCode;
  Bank bank;
  int amount;
  String notes;
  bool isDebit;
  List<Transaction> transactions;
  DateTime expiredDate;
  CreatedBy createdBy;
  DateTime createdDate;
  String updatedBy;
  DateTime updatedDate;
  String deletedBy;
  DateTime deletedDate;

  factory BankList.fromJson(Map<String, dynamic> json) => BankList(
        id: json["Id"],
        userAccountId: json["UserAccountId"],
        userAccount: UserAccount.fromJson(json["UserAccount"]),
        accountIdOwner: json["AccountIdOwner"],
        bankCode: json["BankCode"],
        bank: Bank.fromJson(json["Bank"]),
        amount: json["Amount"],
        notes: json["Notes"],
        isDebit: json["IsDebit"],
        transactions: json["Transactions"] == null
            ? null
            : List<Transaction>.from(
                json["Transactions"].map((x) => Transaction.fromJson(x))),
        expiredDate: DateTime.parse(json["ExpiredDate"]),
        createdBy: createdByValues.map[json["CreatedBy"]],
        createdDate: DateTime.parse(json["CreatedDate"]),
        updatedBy: json["UpdatedBy"],
        updatedDate: DateTime.parse(json["UpdatedDate"]),
        deletedBy: json["DeletedBy"],
        deletedDate: DateTime.parse(json["DeletedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserAccountId": userAccountId,
        "UserAccount": userAccount.toJson(),
        "AccountIdOwner": accountIdOwner,
        "BankCode": bankCode,
        "Bank": bank.toJson(),
        "Amount": amount,
        "Notes": notes,
        "IsDebit": isDebit,
        "Transactions": transactions == null
            ? null
            : List<dynamic>.from(transactions.map((x) => x.toJson())),
        "ExpiredDate": expiredDate.toIso8601String(),
        "CreatedBy": createdByValues.reverse[createdBy],
        "CreatedDate": createdDate.toIso8601String(),
        "UpdatedBy": updatedBy,
        "UpdatedDate": updatedDate.toIso8601String(),
        "DeletedBy": deletedBy,
        "DeletedDate": deletedDate.toIso8601String(),
      };
}

enum CreatedBy { EMPTY, IAL07 }

final createdByValues =
    EnumValues({"": CreatedBy.EMPTY, "ial07": CreatedBy.IAL07});

class Bank {
  Bank({
    this.name,
    this.code,
    this.color,
  });

  String name;
  String code;
  String color;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        name: json["Name"],
        code: json["Code"],
        color: json["Color"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Code": code,
        "Color": color,
      };
}

class UserAccount {
  UserAccount({
    this.id,
    this.bankAccounts,
    this.accountName,
    this.userId,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.deletedBy,
    this.deletedDate,
  });

  int id;
  dynamic bankAccounts;
  String accountName;
  int userId;
  CreatedBy createdBy;
  DateTime createdDate;
  String updatedBy;
  DateTime updatedDate;
  String deletedBy;
  DateTime deletedDate;

  factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
        id: json["Id"],
        bankAccounts: json["BankAccounts"],
        accountName: json["AccountName"],
        userId: json["UserId"],
        createdBy: createdByValues.map[json["CreatedBy"]],
        createdDate: DateTime.parse(json["CreatedDate"]),
        updatedBy: json["UpdatedBy"],
        updatedDate: DateTime.parse(json["UpdatedDate"]),
        deletedBy: json["DeletedBy"],
        deletedDate: DateTime.parse(json["DeletedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "BankAccounts": bankAccounts,
        "AccountName": accountName,
        "UserId": userId,
        "CreatedBy": createdByValues.reverse[createdBy],
        "CreatedDate": createdDate.toIso8601String(),
        "UpdatedBy": updatedBy,
        "UpdatedDate": updatedDate.toIso8601String(),
        "DeletedBy": deletedBy,
        "DeletedDate": deletedDate.toIso8601String(),
      };
}

class Meta {
  Meta({
    this.message,
    this.code,
    this.status,
  });

  String message;
  int code;
  String status;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
        code: json["code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "status": status,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
