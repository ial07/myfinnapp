// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

String dataUserToJson(DataUser data) => json.encode(data.toJson());

class User {
  User({
    this.meta,
    this.data,
  });

  Meta meta;
  List<DataUser> data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        meta: Meta.fromJson(json["meta"]),
        data:
            List<DataUser>.from(json["data"].map((x) => DataUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataUser {
  DataUser({
    this.id,
    this.userName,
    this.password,
    this.email,
    this.telephone,
    this.photo,
    this.isVerified,
    this.bankAccounts,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.deletedBy,
    this.deletedDate,
  });

  int id;
  String userName;
  String password;
  String email;
  String telephone;
  String photo;
  bool isVerified;
  dynamic bankAccounts;
  String createdBy;
  DateTime createdDate;
  String updatedBy;
  DateTime updatedDate;
  String deletedBy;
  DateTime deletedDate;

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        id: json["Id"],
        userName: json["UserName"],
        password: json["Password"],
        email: json["Email"],
        telephone: json["Telephone"],
        photo: json["Photo"],
        isVerified: json["IsVerified"],
        bankAccounts: json["BankAccounts"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserName": userName,
        "Password": password,
        "Email": email,
        "Telephone": telephone,
        "Photo": photo,
        "IsVerified": isVerified,
        "BankAccounts": bankAccounts,
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
