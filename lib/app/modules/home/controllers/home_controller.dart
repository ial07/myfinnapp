import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfinnapp/app/models/AccountBankList.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/service/network_handler.dart';
import 'package:myfinnapp/app/function/sessionHandlerFunction.dart';

class HomeController extends GetxController {
  final dataUser = GetStorage();
  RxInt idBankAccount = 0.obs;

  var getBankList = <BankList>[].obs;
  var getTransactionsList = <Transaction>[].obs;

  @override
  void onInit() {
    getAccountBank();
    super.onInit();
  }

  @override
  void onReady() {
    getTransaction();

    super.onReady();
  }

  void getTransaction() async {
    Map<String, dynamic> data = dataUser.read("dataUser");
    final idUser = data["profile"]["Id"];
    var response =
        await NetworkHandler.get("getbankAccountbyaccountidowner/$idUser");
    if (response.toString().contains('Session End')) {
      sessionHandlerFunction.ExpiredTokenRetryPolicy();
    } else {
      AccountBankList _getAcoountBankListModel =
          AccountBankList.fromJson(jsonDecode(response));
      var items = _getAcoountBankListModel.data.where((e) => e.id == 2);
      print(items);
      print(idBankAccount.value);
      if (items.isNotEmpty) {
        for (var item in items.first.transactions) {
          getTransactionsList.add(Transaction(
              id: item.id,
              amount: item.amount,
              bankAccount: item.bankAccount,
              bankAccountId: item.bankAccountId,
              createdBy: item.createdBy,
              createdDate: item.createdDate,
              notes: item.notes,
              deletedBy: item.deletedBy,
              deletedDate: item.deletedDate,
              updatedBy: item.updatedBy,
              updatedDate: item.updatedDate));
        }
      }
    }
  }

  void getAccountBank() async {
    Map<String, dynamic> data = dataUser.read("dataUser");
    final idUser = data["profile"]["Id"];
    var response =
        await NetworkHandler.get("getbankAccountbyaccountidowner/$idUser");
    if (response.toString().contains('Session End')) {
      sessionHandlerFunction.ExpiredTokenRetryPolicy();
    } else {
      AccountBankList _getAcoountBankListModel =
          AccountBankList.fromJson(jsonDecode(response));
      for (var item in _getAcoountBankListModel.data) {
        getBankList.add(BankList(
            id: item.id,
            accountIdOwner: item.accountIdOwner,
            amount: item.amount,
            bank: item.bank,
            bankCode: item.bankCode,
            userAccountId: item.userAccountId,
            userAccount: item.userAccount,
            notes: item.notes,
            isDebit: item.isDebit,
            expiredDate: item.expiredDate,
            updatedDate: item.updatedDate,
            createdDate: item.createdDate,
            updatedBy: item.updatedBy,
            createdBy: item.createdBy,
            deletedBy: item.deletedBy,
            deletedDate: item.deletedDate));
      }
    }
  }
}
