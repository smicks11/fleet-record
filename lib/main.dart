import 'package:fleet_app/app/controller/device_info_controller.dart';
import 'package:fleet_app/app/controller/global_controller.dart';
import 'package:fleet_app/app/modules/car_portal/controllers/car_portal_controller.dart';
import 'package:fleet_app/app/modules/home/controllers/home_controller.dart';
import 'package:fleet_app/app/modules/login/controllers/login_controller.dart';
import 'package:fleet_app/fleet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
