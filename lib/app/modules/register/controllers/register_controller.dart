import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinnapp/app/function/SnackbarFunction.dart';
import 'package:myfinnapp/app/modules/register/models/register.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/service/network_handler.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> registerKeyForm = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;
  RxBool isConfirmVisible = false.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController nohpC = TextEditingController();
  TextEditingController confirmPassC = TextEditingController();

  Future<void> processRegister() async {
    final isValid = registerKeyForm.currentState.validate();
    if (!isValid) {
      return;
    }
    registerKeyForm.currentState.save();

    if (emailC.text.isNotEmpty &&
        passC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        nohpC.text.isNotEmpty) {
      isLoading.value = true;
      if (emailC.text.isEmail) {
        if (confirmPassC.text == passC.text) {
          RegisterModel registerModel = RegisterModel(
              username: nameC.text,
              email: emailC.text,
              password: passC.text,
              telephone: nohpC.text);

          var response = await NetworkHandler.auth(
              registerModelToJson(registerModel), "register");

          var data = json.decode(response);
          if (data["data"]["token"] != null) {
            Get.offAllNamed(Routes.START_PAGE);
            SnackbarFunction.snackBarSuccess(
                "Your is registered, please verified your account first");
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
      } else {
        isLoading.value = false;
        SnackbarFunction.snackBarError("Please enter the correct email format");
      }
    } else {
      isLoading.value = false;
      // SnackbarFunction.snackBarError("All fields must be filled");
    }
  }
}
