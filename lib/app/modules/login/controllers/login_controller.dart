import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinnapp/app/modules/login/models/login.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/service/network_handler.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

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

  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  Future<void> login() async {
    if (usernameC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      LoginModel loginModel =
          LoginModel(username: usernameC.text, password: passwordC.text);
      var response =
          await NetworkHandler.auth(loginModelToJson(loginModel), "login");

      var data = json.decode(response);
      if (data["data"]["token"] != null) {
        print(data["data"]["profile"]['IsVerified']);
        if (data["data"]["profile"]['IsVerified'] == true) {
          await NetworkHandler.storeToken(data["data"]["token"]);
          Get.offAllNamed(Routes.HOME);
        } else {
          isLoading.value = false;
          Get.defaultDialog(
            title: "Unverified email",
            middleText:
                "Please verified your account first, if there is no message check spam",
            titleStyle: TextStyle(color: Colors.black87),
            radius: 20,
            actions: [
              TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.black),
                  )),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: Text("RE-SEND EMAIL"),
              ),
            ],
          );
        }
      } else {
        isLoading.value = false;
        var errors = data["data"]["errors"];
        snackBarError("$errors");
      }
    } else {
      isLoading.value = false;
      snackBarError("All fields must be filled");
    }
  }
}
