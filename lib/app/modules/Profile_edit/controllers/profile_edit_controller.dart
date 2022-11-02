import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myfinnapp/app/function/SnackbarFunction.dart';
import 'package:myfinnapp/app/models/User.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/service/network_handler.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class ProfileEditController extends GetxController {
  final dataUser = GetStorage();
  RxInt idUser = 0.obs;
  fs.FirebaseStorage storage = fs.FirebaseStorage.instance;

  RxBool isLoading = false.obs;
  // RxBool isVisible = false.obs;
  // RxBool isConfirmVisible = false.obs;

  TextEditingController nameC = TextEditingController();
  TextEditingController nohpC = TextEditingController();

  final ImagePicker pickImg = ImagePicker();

  XFile image;

  void imagePicker() async {
    image = await pickImg.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // print(image.name);
      // print(image.name.split(".").last);
      // print(image.path);

    } else {
      print(image);
    }
    update();
  }

  void getUser() async {
    // Map<String, dynamic> data = dataUser.read("dataUser");
    // idUser.value = data["profile"]["Id"];
    var response = await NetworkHandler.get("getuserbyid/$idUser");
    var result = json.decode(response);
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   nameC.text = Username.value;
  //   nohpC.text = NoHp.value;
  //   print(nameC.text);
  //   super.onReady();
  // }

  Future<void> updateProfile() async {
    if (nameC.text.isNotEmpty && nohpC.text.isNotEmpty) {
      isLoading.value = true;
      var response;
      if (image != null) {
        File file = File(image.path);
        String ext = image.name.split(".").last;

        await storage.ref("${idUser}/profile.${ext}").putFile(file);
        String UrlImage =
            await storage.ref("${idUser}/profile.${ext}").getDownloadURL();
        DataUser profileEditModel = DataUser(
            id: idUser.value,
            userName: nameC.text,
            photo: UrlImage,
            telephone: nohpC.text);
        response = await NetworkHandler.put(
            dataUserToJson(profileEditModel), "edituser");
      } else {
        DataUser profileEditModel = DataUser(
            id: idUser.value, userName: nameC.text, telephone: nohpC.text);
        response = await NetworkHandler.put(
            dataUserToJson(profileEditModel), "edituser");
      }
      var data = json.decode(response);
      print(data);
      isLoading.value = false;
      Get.offAllNamed(Routes.PROFILE_PAGE);
    } else {
      isLoading.value = false;
      // SnackbarFunction.snackBarError("All fields must be filled");
    }
  }
}
