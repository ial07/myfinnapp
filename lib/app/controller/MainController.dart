import 'package:get/get.dart';
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
        Get.offAllNamed(Routes.HOME);
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
