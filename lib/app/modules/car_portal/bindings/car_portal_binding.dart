import 'package:get/get.dart';

import '../controllers/car_portal_controller.dart';

class CarPortalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarPortalController>(
      () => CarPortalController(),
    );
  }
}
