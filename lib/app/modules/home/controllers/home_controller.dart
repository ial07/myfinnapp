import 'package:get/get.dart';
import 'package:myfinnapp/service/network_handler.dart';

class HomeController extends GetxController {
  RxString? token;
  RxBool loggedin = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void checkLogin() async {
    var ScopeToken = await NetworkHandler.getToken();
    if (ScopeToken != null) {
      loggedin.value = true;
      var response = await NetworkHandler.get("getbankdata", ScopeToken);
      print(response);
    }
  }
}
