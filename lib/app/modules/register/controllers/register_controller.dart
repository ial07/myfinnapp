import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinnapp/app/modules/register/models/register.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/service/network_handler.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;
  RxBool isConfirmVisible = false.obs;

  void snackBarError(String error) {
    Get.snackbar(
      "Error",
      "$error",
      icon: Icon(Icons.error, color: Colors.white),
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

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController nohpC = TextEditingController();
  TextEditingController confirmPassC = TextEditingController();

  Future<void> processRegister() async {
    if (emailC.text.isNotEmpty &&
        passC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        nohpC.text.isNotEmpty) {
      if (emailC.text.isEmail) {
        isLoading.value = true;
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
            await NetworkHandler.storeToken(data["data"]["token"]);
            Get.offAllNamed(Routes.LOGIN);
            snackBarError(
                "Your is registered, please verified your account first");
          } else {
            isLoading.value = false;
            var errors = data["data"]["errors"];
            snackBarError("$errors");
          }
        } else {
          isLoading.value = false;
          snackBarError("Confirm password must be the same as the password");
        }
      } else {
        isLoading.value = false;
        snackBarError("Please enter the correct email format");
      }
    } else {
      isLoading.value = false;
      snackBarError("All fields must be filled");
    }
  }
}
