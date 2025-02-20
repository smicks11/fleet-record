// ignore_for_file: non_constant_identifier_names
import 'dart:io';
import 'package:get/get.dart';

class GlobalGetController extends GetxController {
  var user_role = "".obs;
  var user_token = "".obs;
  

  static GlobalGetController get gbMasterController =>
      Get.find<GlobalGetController>();

}
