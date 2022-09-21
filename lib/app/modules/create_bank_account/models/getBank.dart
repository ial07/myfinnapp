// To parse this JSON data, do
//
//     final BankList = bankListFromJson(jsonString);

import 'dart:convert';

BankList bankListFromJson(String str) => BankList.fromJson(json.decode(str));

String bankListToJson(BankList data) => json.encode(data.toJson());

class BankList {
  BankList({
    this.meta,
    this.data,
  });

  Meta meta;
  List<BankData> data;

  factory BankList.fromJson(Map<String, dynamic> json) => BankList(
        meta: Meta.fromJson(json["meta"]),
        data:
            List<BankData>.from(json["data"].map((x) => BankData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BankData {
  BankData({
    this.name,
    this.code,
    this.color,
  });

  String name;
  String code;
  String color;

  factory BankData.fromJson(Map<String, dynamic> json) => BankData(
        name: json["Name"],
        code: json["Code"],
        color: json["Color"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Code": code,
        "Color": color,
      };

  @override
  String toString() => name;
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
