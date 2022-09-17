import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/controller/MainController.dart';

import 'app/routes/app_pages.dart';

void main() {
  final pageC = Get.put(MainController(), permanent: true);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
    ),
  );
}
