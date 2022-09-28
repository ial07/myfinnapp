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
  RxBool isLoading = false.obs;

  RxInt totalAmount = 0.obs;
  RxInt currentAmount = 0.obs;

  var getBankList = <BankList>[].obs;
  var getTransactionsList = <Transaction>[].obs;

  dynamic response = null.obs;

  @override
  void onInit() {
    // getResponse();

    super.onInit();
  }

  @override
  void onReady() {
    getAccountBank();
    getTransaction();

    super.onReady();
  }

  // void getResponse() async {
  //   isLoading.value = true;
  //   Map<String, dynamic> data = dataUser.read("dataUser");
  //   final idUser = data["profile"]["Id"];
  //   response =
  //       await NetworkHandler.get("getbankAccountbyaccountidowner/$idUser");

  //   getTransaction(response);
  // }

  void getTransaction() async {
    isLoading.value = false;
    Map<String, dynamic> data = dataUser.read("dataUser");
    final idUser = data["profile"]["Id"];
    var res =
        await NetworkHandler.get("getbankAccountbyaccountidowner/$idUser");
    if (res.toString().contains('Session End')) {
      sessionHandlerFunction.ExpiredTokenRetryPolicy();
    } else {
      AccountBankList _getAcoountBankListModel =
          AccountBankList.fromJson(jsonDecode(res));
      var items = _getAcoountBankListModel.data
          .where((e) => e.id == idBankAccount.value);
      getTransactionsList.removeRange(0, getTransactionsList.length);

      if (items.isNotEmpty) {
        for (var item in items.first.transactions) {
          getTransactionsList.add(Transaction(
              id: item.id,
              amount: item.amount,
              bankAccount: item.bankAccount,
              bankAccountId: item.bankAccountId,
              createdBy: item.createdBy,
              createdDate: item.createdDate,
              deletedBy: item.deletedBy,
              deletedDate: item.deletedDate,
              notes: item.notes,
              updatedBy: item.updatedBy,
              updatedDate: item.updatedDate));
        }
      }
      update();
    }
  }

  void getAccountBank() async {
    Map<String, dynamic> data = dataUser.read("dataUser");
    final idUser = data["profile"]["Id"];
    var res =
        await NetworkHandler.get("getbankAccountbyaccountidowner/$idUser");
    if (res.toString().contains('Session End')) {
      sessionHandlerFunction.ExpiredTokenRetryPolicy();
    } else {
      AccountBankList _getAcoountBankListModel =
          AccountBankList.fromJson(jsonDecode(res));
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
