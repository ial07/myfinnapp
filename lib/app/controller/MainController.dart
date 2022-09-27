import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinnapp/app/modules/create_trx/views/create_trx_view.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';

class MainController extends GetxController {
  RxInt pageIndex = 0.obs;

  void changePage(int i) async {
    pageIndex.value = i;
    switch (i) {
      case 1:
        Get.offAllNamed(Routes.HOME);
        break;
      case 2:
        Get.bottomSheet(
          CreateTrxView(),
          isScrollControlled: true,
          barrierColor: Colors.black38,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        );
        break;
      case 3:
        Get.offAllNamed(Routes.HOME);
        break;
      case 4:
        Get.offAllNamed(Routes.HOME);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }
}
