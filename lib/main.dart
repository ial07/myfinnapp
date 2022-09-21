import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/controller/MainController.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfinnapp/app/modules/login/controllers/login_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  final pageC = Get.put(MainController(), permanent: true);
  final loginC = Get.put(LoginController());

  final userData = GetStorage();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute:
          userData.read("dataUser") != null ? Routes.HOME : Routes.START_PAGE,
      getPages: AppPages.routes,
    ),
  );
}
