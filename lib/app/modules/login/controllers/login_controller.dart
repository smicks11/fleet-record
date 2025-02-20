// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:fleet_app/app/controller/device_info_controller.dart';
import 'package:fleet_app/app/data/constant.dart';
import 'package:fleet_app/app/routes/app_pages.dart';
import 'package:fleet_app/app/services/authentication_service.dart';
import 'package:fleet_app/app/shared/app_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  RxBool isBusy = false.obs;

  setBusy(bool val) {
    isBusy.value = val;
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final deviceInfoController = Get.find<DeviceInfoController>();
    setBusy(true);

    try {
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
        "device_id": deviceInfoController.deviceId.value,
        "ip_address": deviceInfoController.ipAddress.value,
        "operating_system": deviceInfoController.deviceOs.value,
        "longitude": deviceInfoController.longitude.value.toString(),
        "lattitude": deviceInfoController.latitude.value.toString(),
        "device_name": deviceInfoController.deviceName.value
      };

      final response = await AuthenticationService.loginService(data);
      if (response.status == true) {
        setBusy(false);
        Get.offAllNamed(Routes.OVERVIEW);
      } else {
        setBusy(false);
        AppUtil.showSnackBar(context,
            text: response.message ?? ErrorStatus.requestFailure, error: true);
      }
    } on SocketException {
      AppUtil.showSnackBar(context, text: ErrorStatus.no_internet, error: true);
      setBusy(false);
    } catch (e) {
      AppUtil.showSnackBar(context, text: ErrorStatus.codeError, error: true);
      setBusy(false);
    }
  }
}
