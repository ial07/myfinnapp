import 'dart:convert';

import 'package:flutter_launcher_icons/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:myfinnapp/app/models/AccountBankList.dart';
import 'package:myfinnapp/app/models/User.dart';
import 'package:myfinnapp/service/network_handler.dart';
import 'package:myfinnapp/app/function/sessionHandlerFunction.dart';

class HomeController extends GetxController {
  final dataUser = GetStorage();
  RxInt idUser = 0.obs;
  RxInt idBankAccount = 0.obs;
  RxBool isLoading = false.obs;
  RxDouble getMonthEstimated = 0.0.obs;
  DateTime now = DateTime.now();
  var Year = DateFormat('yyyy').format(DateTime.now()).toString();
  var UserDatas = <DataUser>[].obs;

  RxDouble TotalMonthExpenses = 0.0.obs;
  RxDouble TotalMonthdDebit = 0.0.obs;

  var getBankList = <BankAccount>[].obs;
  var listTransactionByAccountId = {}.obs;

  var getTransactionsList = <Transaction>[].obs;
  // var getTransactionsList = [].obs;
  var getTransactionsListTemp = [].obs;

  dynamic response = null.obs;

  @override
  void onInit() {
    listTransactionByAccountId.value = {};
    // getResponse();
    getAccountBank();
    getUser();
    super.onInit();
  }

  @override
  void onReady() {
    getTransaction();
    getExpenseMonth();
    super.onReady();
  }

  // void getTransaction() async {
  //   getTransactionsList.value = [];
  //   if (getTransactionsListTemp.isNotEmpty) {
  //     for (var i = 0; i < getTransactionsListTemp.length; i++) {
  //       var data = getTransactionsListTemp[i]["BankAccount"];
  //       if (data != null) {
  //         if (data["Id"] == idBankAccount.value) {
  //           getTransactionsList.value = data["Transactions"];
  //         }
  //       }
  //     }
  //   }
  // }

  // void getResponse() async {
  //   isLoading.value = false;
  //   Map<String, dynamic> data = dataUser.read("dataUser");
  //   final idUser = data["profile"]["Id"];
  //   var res =
  //       await NetworkHandler.get("getbankAccountbyaccountidowner/$idUser");
  //   if (res.toString().contains('Session End')) {
  //     sessionHandlerFunction.ExpiredTokenRetryPolicy();
  //   } else {
  //     var data = jsonDecode(res);
  //     if (data["data"].length > 0) {
  //       getTransactionsListTemp.addAll(data["data"]);
  //     }
  //     // getTransaction();
  //   }
  // }

  void getTransaction() async {
    listTransactionByAccountId.value = {};
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
          .where((e) => e.bankAccount.id == idBankAccount.value);
      getTransactionsList.removeRange(0, getTransactionsList.length);

      if (items.isNotEmpty) {
        TotalMonthdDebit.value =
            double.parse(items.first.transactionTotal.toString());
        for (var item in items.first.bankAccount.transactions) {
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
        getBankList.add(BankAccount(
            transactions: item.bankAccount.transactions,
            id: item.bankAccount.id,
            accountIdOwner: item.bankAccount.accountIdOwner,
            amount: item.bankAccount.amount,
            bank: item.bankAccount.bank,
            bankCode: item.bankAccount.bankCode,
            userAccountId: item.bankAccount.userAccountId,
            userAccount: item.bankAccount.userAccount,
            notes: item.bankAccount.notes,
            isDebit: item.bankAccount.isDebit,
            expiredDate: item.bankAccount.expiredDate,
            updatedDate: item.bankAccount.updatedDate,
            createdDate: item.bankAccount.createdDate,
            updatedBy: item.bankAccount.updatedBy,
            createdBy: item.bankAccount.createdBy,
            deletedBy: item.bankAccount.deletedBy,
            deletedDate: item.bankAccount.deletedDate));
      }
    }
  }

  String getMonth() {
    var m = DateFormat('MM').format(now);
    var month = "";
    switch (m) {
      case '01':
        {
          month = "January";
        }
        break;
      case '02':
        {
          month = "February";
        }
        break;
      case '03':
        {
          month = "March";
        }
        break;
      case '04':
        {
          month = "April";
        }
        break;
      case '05':
        {
          month = "May";
        }
        break;
      case '06':
        {
          month = "Juni";
        }
        break;
      case '07':
        {
          month = "July";
        }
        break;
      case '08':
        {
          month = "August";
        }
        break;
      case '09':
        {
          month = "September";
        }
        break;
      case '10':
        {
          month = "October";
        }
        break;
      case '11':
        {
          month = "November";
        }
        break;
      case '12':
        {
          month = "Desember";
        }
        break;
    }
    return month;
  }

  void getExpenseMonth() async {
    Map<String, dynamic> data = dataUser.read("dataUser");
    final idUser = data["profile"]["Id"];
    getMonthEstimated.value = 0.0;
    if (idBankAccount.value != 0) {
      var response = await NetworkHandler.get(
          "gettransactionbybankaccountid/${idBankAccount.value}");
      if (response.toString().contains('Session End')) {
        sessionHandlerFunction.ExpiredTokenRetryPolicy();
      } else {
        var result = json.decode(response);
        if (result.toString().contains('Get Transaction Success')) {
          listTransactionByAccountId.addAll(result["data"]);
          getMonthEstimated.value =
              double.parse(result["data"]["MonthEstimate"].toString());
          if (result["data"]["MonthTotal"]["${getMonth()} $Year"] != null) {
            TotalMonthExpenses.value = double.parse(
                result["data"]["MonthTotal"]["${getMonth()} $Year"].toString());
          } else {
            TotalMonthExpenses.value = 0.0;
          }
        }
      }
    }
  }

  void getUser() async {
    Map<String, dynamic> data = dataUser.read("dataUser");
    idUser.value = data["profile"]["Id"];
    var response = await NetworkHandler.get("getuserbyid/$idUser");
    User getDataUser = User.fromJson(jsonDecode(response));
    for (var item in getDataUser.data) {
      UserDatas.add(DataUser(
          email: item.email,
          id: item.id,
          photo: item.photo,
          telephone: item.telephone,
          userName: item.userName));
    }
  }
}
