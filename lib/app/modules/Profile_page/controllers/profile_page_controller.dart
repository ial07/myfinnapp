import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfinnapp/app/models/User.dart';
import 'package:myfinnapp/service/network_handler.dart';

class ProfilePageController extends GetxController {
  final dataUser = GetStorage();
  RxInt idUser = 0.obs;
  var UserDatas = <DataUser>[].obs;

  void getUser() async {
    Map<String, dynamic> data = dataUser.read("dataUser");
    idUser.value = data["profile"]["Id"];
    var response = await NetworkHandler.get("getuserbyid/$idUser");
    User getDataUser = User.fromJson(jsonDecode(response));
    for (var item in getDataUser.data) {
      UserDatas.add(DataUser(
          email: item.email,
          id: item.id,
          photo: item.photo,
          telephone: item.telephone,
          userName: item.userName));
    }
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }
}
