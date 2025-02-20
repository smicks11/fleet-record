import 'package:get/get.dart';

import '../modules/car_portal/bindings/car_portal_binding.dart';
import '../modules/car_portal/views/car_portal_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/integration/bindings/integration_binding.dart';
import '../modules/integration/views/integration_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/overview/bindings/overview_binding.dart';
import '../modules/overview/views/overview_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OVERVIEW,
      page: () => const OverviewView(),
      binding: OverviewBinding(),
    ),
    GetPage(
      name: _Paths.CAR_PORTAL,
      page: () => const CarPortalView(),
      binding: CarPortalBinding(),
    ),
    GetPage(
      name: _Paths.INTEGRATION,
      page: () => const IntegrationView(),
      binding: IntegrationBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
