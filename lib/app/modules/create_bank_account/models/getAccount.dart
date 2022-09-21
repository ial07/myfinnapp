// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  Account({
    this.meta,
    this.data,
  });

  Meta meta;
  List<Datum> data;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        meta: Meta.fromJson(json["meta"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
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
  String accountName;
  int userId;
  String createdBy;
  DateTime createdDate;
  String updatedBy;
  DateTime updatedDate;
  String deletedBy;
  DateTime deletedDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["Id"],
        accountName: json["AccountName"],
        userId: json["UserId"],
        createdBy: json["CreatedBy"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        updatedBy: json["UpdatedBy"],
        updatedDate: DateTime.parse(json["UpdatedDate"]),
        deletedBy: json["DeletedBy"],
        deletedDate: DateTime.parse(json["DeletedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "AccountName": accountName,
        "UserId": userId,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate.toIso8601String(),
        "UpdatedBy": updatedBy,
        "UpdatedDate": updatedDate.toIso8601String(),
        "DeletedBy": deletedBy,
        "DeletedDate": deletedDate.toIso8601String(),
      };

  @override
  String toString() => accountName;
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
