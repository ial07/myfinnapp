import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileEditController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;
  RxBool isConfirmVisible = false.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController oldPassC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController nohpC = TextEditingController();
  TextEditingController newPassC = TextEditingController();
  TextEditingController confirmNewPassC = TextEditingController();
}
