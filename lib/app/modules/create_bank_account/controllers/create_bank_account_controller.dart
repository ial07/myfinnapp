import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfinnapp/app/function/SnackbarFunction.dart';
import 'package:myfinnapp/app/modules/create_bank_account/models/createAccount.dart';
import 'package:myfinnapp/app/modules/create_bank_account/models/createBankAccount.dart';
import 'package:myfinnapp/app/modules/create_bank_account/models/getAccount.dart';
import 'package:myfinnapp/app/modules/create_bank_account/models/getBank.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/service/network_handler.dart';
import 'package:myfinnapp/app/function/sessionHandlerFunction.dart';

class CreateBankAccountController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAccount = false.obs;
  RxBool isDebit = false.obs;

  var getAccountList = <Datum>[].obs;
  var getBankList = <BankData>[].obs;

  RxInt idAccount = 0.obs;
  RxString CodeBank = "0".obs;
  TextEditingController accountNameC = TextEditingController();
  TextEditingController AmountC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController NotesC = TextEditingController();

  void chooseDate() async {
    DateTime pickedDate = await showDatePicker(
      context: Get.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2080),
    );
    if (pickedDate != null) {
      dateC.text = DateFormat("yyyy-MM-dd").format(pickedDate).toString();
    }
  }

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
        SnackbarFunction.snackBarSuccess(data["meta"]["message"]);
        accountNameC.text = '';
      }
      // Create UserAccount Success
    } else {
      isLoadingAccount.value = false;
      SnackbarFunction.snackBarError("Please type account first");
    }
  }

  Future<void> SubmitBank() async {
    final dataUser = GetStorage();
    Map<String, dynamic> data = dataUser.read("dataUser");
    final idUser = data["profile"]["Id"];
    String newDate;

    if (dateC.text.isNotEmpty) {
      newDate = DateTime.parse(dateC.text).toIso8601String();
    } else {
      newDate = null;
    }

    if (idAccount.value.isGreaterThan(0) &&
        CodeBank.value.isNotEmpty &&
        AmountC.text.isNotEmpty &&
        NotesC.text.isNotEmpty) {
      isLoading.value = true;

      CreateBankAccountModel accountBankModel = CreateBankAccountModel(
          AccountIdOwner: idUser,
          Amount: double.parse(AmountC.text),
          UserAccountId: idAccount.value,
          BankCode: CodeBank.value,
          Notes: NotesC.text,
          ExpiredDate: newDate,
          IsDebit: isDebit.value);
      var response = await NetworkHandler.post(
          createBankAccountModelToJson(accountBankModel), "createbankAccount");
      print(createBankAccountModelToJson(accountBankModel));
      var data = json.decode(response);
      print(data);
      if (data["meta"]["code"] == 200) {
        isLoading.value = false;

        Get.offAllNamed(Routes.HOME);
        SnackbarFunction.snackBarSuccess(data["meta"]["message"]);
        accountNameC.text = '';
        AmountC.text = '';
        CodeBank.value = '';
        idAccount.value = 0;
        NotesC.text = '';
        dateC.text = '';
        isDebit.value = false;
      }
      // // Create UserAccount Success
    } else {
      isLoading.value = false;
      SnackbarFunction.snackBarError("Please filled all fields");
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
    if (response.toString().contains('Session End')) {
      sessionHandlerFunction.ExpiredTokenRetryPolicy();
    } else {
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
  }

  void fetchBank() async {
    var response = await NetworkHandler.get("getbankdata");
    if (response.toString().contains('Session End')) {
      sessionHandlerFunction.ExpiredTokenRetryPolicy();
    } else {
      BankList _getBankModel = BankList.fromJson(jsonDecode(response));
      for (var item in _getBankModel.data) {
        getBankList
            .add(BankData(name: item.name, code: item.code, color: item.color));
      }
    }
  }
}
