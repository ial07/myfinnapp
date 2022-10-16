import 'package:get/get.dart';

class StaticCreditController extends GetxController {
  RxInt valueChoose = 0.obs;
  RxInt activeDay = 0.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
