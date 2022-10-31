import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfinnapp/app/function/SnackbarFunction.dart';
import 'package:myfinnapp/app/models/AccountBankList.dart';
import 'package:myfinnapp/app/modules/create_trx/models/create_trx.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/service/network_handler.dart';

class CreateTrxController extends GetxController {
  final dataUser = GetStorage();
  RxBool isLoading = false.obs;

  RxInt idBankAccount = 0.obs;

  var getAccountBankList = <BankAccount>[].obs;

  TextEditingController BankAccountNameC = TextEditingController();
  TextEditingController AmountC = TextEditingController();
  TextEditingController NotesC = TextEditingController();

  Future<void> SubmitTransaction() async {
    final dataUser = GetStorage();
    Map<String, dynamic> data = dataUser.read("dataUser");
    final idUser = data["profile"]["Id"];
    var Amount = AmountC.text.replaceAll("Rp. ", "").replaceAll(".", "");

    if (idBankAccount.value.isGreaterThan(0) &&
        AmountC.text.isNotEmpty &&
        NotesC.text.isNotEmpty) {
      isLoading.value = true;

      CreateTRXModel accountBankModel = CreateTRXModel(
          bankaccountid: idBankAccount.value,
          Amount: double.parse(Amount),
          Notes: NotesC.text);
      var response = await NetworkHandler.post(
          createTRXModelToJson(accountBankModel), "createtransaction");
      var data = json.decode(response);
      if (data["meta"]["code"] == 200) {
        isLoading.value = false;

        Get.offAndToNamed(Routes.HOME);
        SnackbarFunction.snackBarSuccess(data["meta"]["message"]);
        idBankAccount.value = 0;
        AmountC.text = '';
        NotesC.text = '';
      }
    } else {
      isLoading.value = false;
      SnackbarFunction.snackBarError("Please filled all fields");
    }
  }

  @override
  void onInit() {
    fetchAccountBank();

    super.onInit();
  }

  void fetchAccountBank() async {
    Map<String, dynamic> data = dataUser.read("dataUser");
    final idUser = data["profile"]["Id"];
    var response =
        await NetworkHandler.get("getbankAccountbyaccountidowner/$idUser");
    AccountBankList _getAcoountBankListModel =
        AccountBankList.fromJson(jsonDecode(response));
    for (var item in _getAcoountBankListModel.data) {
      getAccountBankList.add(BankAccount(
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
