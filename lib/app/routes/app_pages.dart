import 'package:get/get.dart';

import '../modules/Profile_edit/bindings/profile_edit_binding.dart';
import '../modules/Profile_edit/views/profile_edit_view.dart';
import '../modules/Profile_page/bindings/profile_page_binding.dart';
import '../modules/Profile_page/views/profile_page_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/contact_us/views/contact_us_view.dart';
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
import '../modules/staticCredit/bindings/static_credit_binding.dart';
import '../modules/staticCredit/views/static_credit_view.dart';
import '../modules/statistic/bindings/statistic_binding.dart';
import '../modules/statistic/views/statistic_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: Transition.noTransition),
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
    GetPage(
      name: _Paths.STATISTIC,
      page: () => StatisticView(),
      binding: StatisticBinding(),
    ),
    GetPage(
        name: _Paths.PROFILE_PAGE,
        page: () => ProfilePageView(),
        binding: ProfilePageBinding(),
        transition: Transition.noTransition),
    GetPage(
      name: _Paths.PROFILE_EDIT,
      page: () => ProfileEditView(),
      binding: ProfileEditBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.STATIC_CREDIT,
      page: () => StaticCreditView(),
      binding: StaticCreditBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => ContactUsView(),
      binding: ContactUsBinding(),
    ),
  ];
}
