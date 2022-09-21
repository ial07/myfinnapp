import 'package:get/get.dart';

import '../controllers/create_bank_account_controller.dart';

class CreateBankAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateBankAccountController>(
      () => CreateBankAccountController(),
    );
  }
}
