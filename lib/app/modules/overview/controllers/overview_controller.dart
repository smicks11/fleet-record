import 'package:fleet_app/app/modules/car_portal/views/car_detail_view.dart';
import 'package:fleet_app/app/modules/car_portal/views/car_portal_view.dart';
import 'package:fleet_app/app/modules/home/views/home_view.dart';
import 'package:fleet_app/app/modules/settings/views/settings_view.dart';
import 'package:fleet_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class OverviewController extends GetxController {
  final RxString currentRoute = Routes.OVERVIEW.obs;

  void navigateTo(String route) {
    currentRoute.value = route;
    Get.offNamed(route, id: 1);
  }

  void onPressedProfile() {
    // Handle profile press action
  }

  // Method to return the correct page based on the route
  GetView getPage(String? route) {
    switch (route) {
      case Routes.HOME:
        return HomeView();
      case Routes.CAR_PORTAL:
        return CarPortalView();
      case '/car_portal/car_detail':  
      return CarDetailView();
      case Routes.SETTINGS:
        return SettingsView();
      default:
        return HomeView();
    }
  }
}
