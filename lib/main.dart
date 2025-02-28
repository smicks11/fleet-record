import 'package:firebase_core/firebase_core.dart';
import 'package:fleet_app/app/controller/device_info_controller.dart';
import 'package:fleet_app/app/controller/global_controller.dart';
import 'package:fleet_app/app/modules/car_portal/controllers/car_portal_controller.dart';
import 'package:fleet_app/app/modules/home/controllers/home_controller.dart';
import 'package:fleet_app/app/modules/login/controllers/login_controller.dart';
import 'package:fleet_app/firebase_options.dart';
import 'package:fleet_app/fleet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  registerControllers();
  runApp(FleetApp());
}

void registerControllers() {
  Get.put(GlobalGetController());
  Get.put(DeviceInfoController());
  Get.put(LoginController());
  Get.put(HomeController());
  Get.put(CarPortalController());
}
