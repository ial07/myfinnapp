import 'package:get/get.dart';

import '../modules/create_bank_account/bindings/create_bank_account_binding.dart';
import '../modules/create_bank_account/views/create_bank_account_view.dart';
import '../modules/create_trx/bindings/create_trx_binding.dart';
import '../modules/create_trx/views/create_trx_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/start_page/bindings/start_page_binding.dart';
import '../modules/start_page/views/start_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.START_PAGE,
      page: () => StartPageView(),
      binding: StartPageBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_BANK_ACCOUNT,
      page: () => CreateBankAccountView(),
      binding: CreateBankAccountBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_TRX,
      page: () => CreateTrxView(),
      binding: CreateTrxBinding(),
    ),
  ];
}
