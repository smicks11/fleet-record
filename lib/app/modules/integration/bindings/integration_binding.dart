import 'package:get/get.dart';

import '../controllers/integration_controller.dart';

class IntegrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntegrationController>(
      () => IntegrationController(),
    );
  }
}
