import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/app/utils/Iconback.dart';

import '../controllers/login_controller.dart';
import '../../../utils/color.dart' as color;
import '../../../utils/InputForm.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color.AppColor.PageBackground,
      body: SingleChildScrollView(
        child: Form(
          key: controller.loginFormKey,
          child: Container(
            padding: EdgeInsets.only(
                top: size.height * 0.07,
                left: size.width * 0.1,
                right: size.width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //icon Back
                IconBack(size: size.height * 0.15),

                /// Title login
                Text(
                  "LOGIN",
                  style: GoogleFonts.montserrat(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.08),

                /// Input group
                InputForm(
                  Title: "Email / Username",
                  HintText: "Enter email or username",
                  Controller: controller.usernameC,
                  ControllerValidator: (value) {
                    if (value.length <= 0) {
                      return 'please enter right email or username';
                    }
                    return null;
                  },
                ),
                Text("Password",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.passwordC,
                  autocorrect: false,
                  obscureText: true,
                  validator: (value) {
                    if (value.length <= 0) {
                      return 'please type your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    hintText: "Enter password",
                    filled: true,
                    fillColor: Colors.blue[50],
                  ),
                ),
                SizedBox(height: 30),

                ///Button
                Obx(() => SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (controller.isLoading.isFalse) {
                            await controller.login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue[600],
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: Color.fromRGBO(0, 160, 227, 1)))),
                        child: Text(
                          controller.isLoading.isFalse ? "LOGIN" : "LOADING...",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account.",
                        style: GoogleFonts.montserrat()),
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.REGISTER),
                      child: Text("REGISTER", style: GoogleFonts.montserrat()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
