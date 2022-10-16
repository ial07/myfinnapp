import 'package:get/get.dart';

import '../controllers/static_credit_controller.dart';

class StaticCreditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaticCreditController>(
      () => StaticCreditController(),
    );
  }
}
