import 'package:get/get.dart';

import '../controllers/create_trx_controller.dart';

class CreateTrxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTrxController>(
      () => CreateTrxController(),
    );
  }
}
