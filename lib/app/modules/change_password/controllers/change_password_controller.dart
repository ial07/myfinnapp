import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfinnapp/app/function/SnackbarFunction.dart';
import 'package:myfinnapp/app/modules/change_password/model/changePass.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/service/network_handler.dart';

class ChangePasswordController extends GetxController {
  final dataUser = GetStorage();
  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;
  RxBool isConfirmVisible = false.obs;

  TextEditingController oldPassC = TextEditingController();
  TextEditingController newPassC = TextEditingController();
  TextEditingController confirmNewPassC = TextEditingController();

  Future<void> changePass() async {
    Map<String, dynamic> data = dataUser.read("dataUser");
    final idUser = data["profile"]["Id"];

    if (newPassC.text == confirmNewPassC.text) {
      isLoading.value = true;
      ChangePassModel changePassModel = ChangePassModel(
          id: idUser, passwordnew: newPassC.text, passwordold: oldPassC.text);

      var response = await NetworkHandler.put(
          changePassModelToJson(changePassModel), "changepassword");

      var data = json.decode(response);
      if (data["meta"]["code"] == 200) {
        Get.offAllNamed(Routes.PROFILE_PAGE);
        SnackbarFunction.snackBarSuccess("Success change your password");
      } else {
        isLoading.value = false;
        var errors = data["data"]["errors"];
        SnackbarFunction.snackBarError("$errors");
      }
    } else {
      isLoading.value = false;
      SnackbarFunction.snackBarError(
          "Confirm password must be the same as the password");
    }
  }
}
