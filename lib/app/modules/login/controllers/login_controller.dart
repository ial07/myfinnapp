import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfinnapp/app/function/SnackbarFunction.dart';
import 'package:myfinnapp/app/modules/login/models/login.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/service/network_handler.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxInt idUser = 0.obs;

  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  Future<void> login() async {
    final isValid = loginFormKey.currentState.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState.save();
    if (usernameC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      LoginModel loginModel =
          LoginModel(username: usernameC.text, password: passwordC.text);
      var response =
          await NetworkHandler.auth(loginModelToJson(loginModel), "login");
      var data = json.decode(response);
      idUser.value = data["data"]["id"];
      if (response.toString().contains('email not verified yet')) {
        isLoading.value = false;
        Get.defaultDialog(
          title: "Email not verified yet",
          middleText:
              "Please verified your account first, if there is no message check spam",
          titleStyle: TextStyle(color: Colors.black87),
          radius: 20,
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  "CANCEL",
                  style: TextStyle(color: Colors.blue[600]),
                )),
            ElevatedButton(
              onPressed: () async {
                await NetworkHandler.resendEmail("resendemail/$idUser");
                Get.back();
                SnackbarFunction.snackBarSuccess(
                    "success to resend email, please check your inbox email");
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue[600]),
              child: Text("RE-SEND EMAIL"),
            ),
          ],
        );
      } else {
        if (data["data"]["token"] != null) {
          await NetworkHandler.storeData(data["data"]);
          isLoading.value = false;
          Get.offAllNamed(Routes.HOME);
        } else {
          isLoading.value = false;
          SnackbarFunction.snackBarError(data['data']['errors']);
        }
      }
    } else {
      isLoading.value = false;
      // SnackbarFunction.snackBarError("All fields must be filled");
    }
  }
}
