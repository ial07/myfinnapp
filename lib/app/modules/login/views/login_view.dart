import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.usernameC,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Username / email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.passwordC,
            obscureText: true,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 30),
          Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.login();
                  }
                },
                child:
                    Text(controller.isLoading.isFalse ? "LOGIN" : "LOADING..."),
              )),
          SizedBox(height: 10),
          TextButton(
              onPressed: () {},
              // onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
              child: Text("Forgot password")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account."),
              TextButton(
                onPressed: () => Get.offAllNamed(Routes.REGISTER),
                child: Text("REGISTER"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
