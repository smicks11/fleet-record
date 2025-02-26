import 'package:fleet_app/app/data/constant.dart';
import 'package:fleet_app/app/data/vehicle_infographic.dart';
import 'package:fleet_app/app/services/remote_service.dart';
import 'package:fleet_app/app/shared/app_util.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;

  initialize() async {
    await Future.wait([
      getVehicleInfographic(),
    ]);
  }

  RxBool isBusy = false.obs;

  setBusy(bool val) {
    isBusy.value = val;
  }

  var vehicleInfographic = Rx<VehicleInfographic?>(null);

  Future<void> getVehicleInfographic() async {
    setBusy(true);
    try {
      final res = await RemoteService.getVehicleInfographicService();
      if (res.status == true) {
        vehicleInfographic.value = res.data;
      } else {
        AppUtil.showSnackBar(
            text: res.message ?? ErrorStatus.requestFailure, error: true);
      }
    } catch (e) {
      AppUtil.showSnackBar(text: ErrorStatus.codeError, error: true);
    } finally {
      setBusy(false);
      update();
    }
  }
}
