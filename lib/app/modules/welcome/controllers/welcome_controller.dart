import 'package:fleet_app/app/data/constant.dart';
import 'package:fleet_app/app/data/vehicle_payload.dart';
import 'package:fleet_app/app/services/remote_service.dart';
import 'package:fleet_app/app/shared/app_util.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  //TODO: Implement WelcomeController

  final count = 0.obs;

  final RxBool showResults = false.obs;
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

  RxList<Vehicle> vehicles = <Vehicle>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;
  int currentPage = 1;
  final int pageSize = 50;

  Future<void> fetchVehicles(
      {bool isRefresh = false, String? searchQuery}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMore.value = true;
      vehicles.clear();
    }

    if (!hasMore.value || isLoading.value) return;

    isLoading.value = true;
    try {
      Map<String, dynamic> params = {
        'page_size': pageSize,
        'page': currentPage
      };
      if (searchQuery != null && searchQuery.isNotEmpty) {
        params['search'] = searchQuery;
      }
      final res = await RemoteService.getVehicleService(params: params);

      if (res.status == true) {
        final newVehicles = res.data?.data?.vehicles;

        if (newVehicles != null && newVehicles.isNotEmpty) {
          final existingIds = vehicles.map((v) => v.id).toSet();

          for (var vehicle in newVehicles) {
            if (!existingIds.contains(vehicle.id)) {
              vehicles.add(vehicle);
            }
          }

          currentPage++;
        } else {
          hasMore.value = false;
        }
      } else {
        AppUtil.showSnackBar(
            text: res.message ?? ErrorStatus.requestFailure, error: true);
      }
    } catch (e) {
      AppUtil.showSnackBar(text: ErrorStatus.codeError, error: true);
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
