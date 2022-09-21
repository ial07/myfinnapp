import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfinnapp/service/network_handler.dart';

class HomeController extends GetxController {
  final dataUser = GetStorage();

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void checkLogin() async {
    var response = await NetworkHandler.get("getbankdata");
    print(response);
  }
}
