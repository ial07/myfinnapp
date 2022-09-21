import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfinnapp/app/modules/create_bank_account/models/createAccount.dart';
import 'package:myfinnapp/app/modules/create_bank_account/models/getAccount.dart';
import 'package:myfinnapp/app/modules/create_bank_account/models/getBank.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/service/network_handler.dart';

class CreateBankAccountController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAccount = false.obs;
  RxBool isDebit = false.obs;
  RxInt idAccount = 0.obs;
  RxString CodeBank = "0".obs;
  var getAccountList = <Datum>[].obs;
  var getBankList = <BankData>[].obs;

  void snackBarError(String error) {
    Get.snackbar(
      "Error",
      "$error",
      icon: Icon(Icons.person, color: Colors.white),
      backgroundColor: Colors.red,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  void snackBarSuccess(String success) {
    Get.snackbar(
      "Success",
      "$success",
      icon: Icon(Icons.check, color: Colors.white),
      backgroundColor: Colors.green,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  TextEditingController accountNameC = TextEditingController();

  Future<void> addAccount() async {
    if (accountNameC.text.isNotEmpty) {
      isLoadingAccount.value = true;
      CreateAccountModel accountModel =
          CreateAccountModel(accountname: accountNameC.text);
      var response = await NetworkHandler.post(
          createAccountModelToJson(accountModel), "createuserAccount");
      var data = json.decode(response);
      if (data["meta"]["code"] == 200) {
        isLoadingAccount.value = false;

        Get.offAllNamed(Routes.HOME);
        snackBarSuccess(data["meta"]["message"]);
        accountNameC.text = '';
      }
      // Create UserAccount Success
    } else {
      isLoadingAccount.value = false;
      snackBarError("Please type account first");
    }
  }

  @override
  void onInit() {
    fetchUserAccount();
    fetchBank();

    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    getAccountList;
    super.dispose();
  }

  void fetchUserAccount() async {
    final dataUser = GetStorage();
    Map<String, dynamic> data = dataUser.read("dataUser");
    final idUser = data["profile"]["Id"];
    var response = await NetworkHandler.get("getuserAccountbyuserid/$idUser");
    if (json.decode(response)["meta"]["code"] == 200) {
      Account _getAccountModel = Account.fromJson(jsonDecode(response));
      for (var item in _getAccountModel.data) {
        getAccountList.add(Datum(
            id: item.id,
            accountName: item.accountName,
            userId: item.userId,
            createdBy: item.createdBy,
            createdDate: item.createdDate,
            updatedBy: item.updatedBy,
            updatedDate: item.updatedDate,
            deletedBy: item.deletedBy,
            deletedDate: item.deletedDate));
      }
    } else {
      getAccountList.add(Datum(
          id: 0,
          accountName: "",
          createdBy: "",
          createdDate: null,
          deletedBy: "",
          deletedDate: null,
          updatedBy: "",
          updatedDate: null,
          userId: 0));
    }
  }

  void fetchBank() async {
    var response = await NetworkHandler.get("getbankdata");
    BankList _getBankModel = BankList.fromJson(jsonDecode(response));
    for (var item in _getBankModel.data) {
      getBankList
          .add(BankData(name: item.name, code: item.code, color: item.color));
    }
  }
}
