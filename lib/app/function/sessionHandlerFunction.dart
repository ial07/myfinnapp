import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';

class sessionHandlerFunction {
  static ExpiredTokenRetryPolicy() {
    GetStorage().erase();
    Get.offAllNamed(Routes.START_PAGE);
    Get.snackbar(
      "Error",
      "Your session has expired, please login again",
      icon: Icon(Icons.warning, color: Colors.white),
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
}
