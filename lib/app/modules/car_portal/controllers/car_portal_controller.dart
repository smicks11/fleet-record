import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:fleet_app/app/data/constant.dart';
import 'package:fleet_app/app/data/vehicle_payload.dart';
import 'package:fleet_app/app/modules/login/controllers/login_controller.dart';
import 'package:fleet_app/app/services/remote_service.dart';
import 'package:fleet_app/app/shared/app_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:intl/intl.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

class CarPortalController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;

  RxBool isBusy = false.obs;

  setBusy(bool val) {
    isBusy.value = val;
  }

  initialize() {
    fetchVehicles(isRefresh: true);
  }

  Future<void> createVehicle({
    required String vehicleBrandId,
    required String assetCode,
    required String regNumber,
    required String vehicleCategory,
    required String dateOfPurchase,
    required int costOfPurchase,
    required int netBookValue,
    required String parkingBranch,
    required String vehicleType,
    required String tyreType,
    required String batteryType,
    required int tankCapacity,
    required String vehicleStatus,
    required String maintenanceGarage,
    // required String fuelType,
    // required bool available,
    required String vehicleModel,
    required String teamId,
    required String driverId,
    required List<String> images,
  }) async {
    try {
      Map<String, dynamic> data = {
        // "vehicle_brand_id": vehicleBrandId,
        "asset_code": assetCode.trim(),
        "reg_number": regNumber.trim(),
        "vehicle_category": vehicleCategory.trim(),
        "date_of_purchase": dateOfPurchase.trim(),
        "cost_of_purchase": costOfPurchase,
        "net_book_value": netBookValue,
        "parking_branch": parkingBranch.trim(),
        "vehicle_type": vehicleType.trim(),
        "tyre_type": tyreType.trim(),
        "battery_type": batteryType.trim(),
        "tank_capacity": tankCapacity,
        "vehicle_status": vehicleStatus.trim(),
        "maintenance_garage": maintenanceGarage.trim(),
        // "fuel_type": fuelType.trim(),
        // "available": available,
        "vehicle_model": vehicleModel.trim(),
        "team_id": teamId,
        "driver_id": driverId,
        "images": images,
      };

      final response = await RemoteService.createVehicleService(data);
      if (response.status == true) {
        Get.back();
        AppUtil.showSnackBar(
            text: response.message ?? 'Vehicle added successfully',
            error: false);
      } else {
        AppUtil.showSnackBar(
            text: response.message ?? ErrorStatus.requestFailure, error: true);
      }
    } catch (e) {
      AppUtil.showSnackBar(text: ErrorStatus.codeError, error: true);
    } finally {}
  }

  Future<String?> createDriver({
    required String name,
    required String driverId,
    required String phoneNumber,
    required String dateEmployed,
    required int level,
    required String serviceProvider,
  }) async {
    try {
      Map<String, dynamic> data = {
        "name": name.trim(),
        "driver_id": driverId.trim(),
        "phone_number": phoneNumber.trim(),
        "date_employed": dateEmployed.trim(),
        "level": level,
        "service_provider": serviceProvider.trim(),
      };

      final response = await RemoteService.createDriverService(data);

      if (response.status == true && response.data != null) {
        String driverId = response.data['data']['id'];
        return driverId;
      } else {
        AppUtil.showSnackBar(
            text: response.message ?? ErrorStatus.requestFailure, error: true);
        return null;
      }
    } catch (e) {
      AppUtil.showSnackBar(text: ErrorStatus.codeError, error: true);
      return null;
    } finally {}
  }

  Future<String?> createTeam({
    required String className,
    required String division,
    required String group,
    required String unit,
    required String teamBranch,
    required String pcCode,
    required String region,
  }) async {
    try {
      Map<String, dynamic> data = {
        "class_name": className.trim(),
        "division": division.trim(),
        "group": group.trim(),
        "unit": unit.trim(),
        "team_branch": teamBranch.trim(),
        "pc_code": pcCode.trim(),
        "region": region.trim(),
      };

      final response = await RemoteService.createTeamService(data);

      if (response.status == true && response.data != null) {
        String teamId = response.data['data']['id'];
        return teamId;
      } else {
        AppUtil.showSnackBar(
            text: response.message ?? ErrorStatus.requestFailure, error: true);
        return null;
      }
    } catch (e) {
      AppUtil.showSnackBar(text: ErrorStatus.codeError, error: true);
      return null;
    } finally {}
  }

  Future<void> startCreationProcess({
    required String name,
    required String parseddriverId,
    required String phoneNumber,
    required String dateEmployed,
    required int level,
    required String serviceProvider,
    required String className,
    required String division,
    required String group,
    required String unit,
    required String teamBranch,
    required String pcCode,
    required String region,
    required String vehicleBrandId,
    required String assetCode,
    required String regNumber,
    required String vehicleCategory,
    required String dateOfPurchase,
    required int costOfPurchase,
    required int netBookValue,
    required String parkingBranch,
    required String vehicleType,
    required String tyreType,
    required String batteryType,
    required int tankCapacity,
    required String vehicleStatus,
    required String maintenanceGarage,
    // required String fuelType,
    // required bool available,
    required String vehicleModel,
    required List<dynamic> images,
  }) async {
    try {
      setBusy(true);

      // 1. Upload images first
      List<String> imageUrls = await uploadVehicleImages(images);
      if (imageUrls.isEmpty) {
        throw Exception("Failed to upload images");
      }

      // 2. Create driver & team concurrently
      final results = await Future.wait([
        createDriver(
          name: name,
          driverId: parseddriverId,
          phoneNumber: phoneNumber,
          dateEmployed: dateEmployed,
          level: level,
          serviceProvider: serviceProvider,
        ),
        createTeam(
          className: className,
          division: division,
          group: group,
          unit: unit,
          teamBranch: teamBranch,
          pcCode: pcCode,
          region: region,
        )
      ]);

      String? driverId = results[0];
      String? teamId = results[1];

      if (driverId == null || teamId == null) {
        throw Exception("Failed to create driver or team");
      }

      // 3. Create vehicle
      await createVehicle(
        vehicleBrandId: vehicleBrandId,
        assetCode: assetCode,
        regNumber: regNumber,
        vehicleCategory: vehicleCategory,
        dateOfPurchase: dateOfPurchase,
        costOfPurchase: costOfPurchase,
        netBookValue: netBookValue,
        parkingBranch: parkingBranch,
        vehicleType: vehicleType,
        tyreType: tyreType,
        batteryType: batteryType,
        tankCapacity: tankCapacity,
        vehicleStatus: vehicleStatus,
        maintenanceGarage: maintenanceGarage,
        // fuelType: fuelType,
        // available: available,
        vehicleModel: vehicleModel,
        teamId: teamId,
        driverId: driverId,
        images: imageUrls,
      );
    } catch (e) {
      AppUtil.showSnackBar(
          text: "Creation failed: ${e.toString()}", error: true);
    } finally {
      await fetchVehicles(isRefresh: true);
      setBusy(false);
    }
  }

  Future<List<String>> uploadVehicleImages(List<dynamic> images) async {
    try {
      dio.Dio dioInstance = dio.Dio();

      List<dio.MultipartFile> files = [];

      for (var image in images) {
        if (kIsWeb) {
          String mimeType = "image/png";
          List<int> uint8List = image as Uint8List;

          files.add(dio.MultipartFile.fromBytes(
            uint8List,
            filename: "image.png",
            contentType: MediaType("image", "png"),
          ));
        } else {
          String type = mime(image.path) ?? "image/jpg";
          List<String> mimeTypeList = type.split("/");

          files.add(await dio.MultipartFile.fromFile(
            image.path,
            contentType: MediaType(mimeTypeList[0], mimeTypeList[1]),
          ));
        }
      }

      dio.FormData formData = dio.FormData.fromMap({"file": files});

      final response = await dioInstance.post(
        "https://api.fleetdb.xyz/api/v1/vehicle/upload-images",
        data: formData,
        options: dio.Options(
          headers: {
            "Authorization":
                'Bearer ${Get.find<LoginController>().loginPayload.value?.data?.accessToken}',
            "Content-Type": "multipart/form-data",
          },
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        debugPrint('images uploaded success');
        return List<String>.from(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? "Image upload failed");
      }
    } catch (e) {
      return [];
    }
  }

  // Future<List<String>> uploadVehicleImages(List<File> images) async {
  //   try {
  //     dio.Dio dioInstance = dio.Dio();

  //     List<dio.MultipartFile> files = images.map((file) {
  //       String type = mime(file.path) ?? "image/jpg";
  //       List<String> mimeTypeList = type.split("/");

  //       return MultipartFileRecreatable.fromFileSync(
  //         file.path,
  //         contentType: MediaType(mimeTypeList[0], mimeTypeList[1]),
  //       );
  //     }).toList();

  //     dio.FormData formData = dio.FormData.fromMap({"file": files});

  //     final response = await dioInstance.post(
  //       "https://api.fleetdb.xyz/api/v1/vehicle/upload-images",
  //       data: formData,
  //       options: dio.Options(
  //         headers: {
  //           "Authorization": "Bearer ${Get.find<LoginController>().loginPayload.value?.data?.accessToken}",
  //           "Content-Type": "multipart/form-data",
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200 && response.data['success'] == true) {
  //       return List<String>.from(
  //           response.data['data']); // Return uploaded image URLs
  //     } else {
  //       throw Exception(response.data['message'] ?? "Image upload failed");
  //     }
  //   } catch (e) {
  //     print("Error uploading images: $e");
  //     return [];
  //   }
  // }

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

  RxString currentVehicleId = ''.obs;

  var vehicleDetail = Rx<Vehicle?>(null);

  Future<void> getVehicleDetail() async {
    debugPrint('this is vehicle id: ${currentVehicleId.value}');
    setBusy(true);
    try {
      final res = await RemoteService.getVehicleDetailService(
          id: currentVehicleId.value);
      if (res.status == true) {
        vehicleDetail.value = res.data?.data?.vehicles?[0];
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

  String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'Invalid date';
    }

    DateTime date = DateTime.parse(dateString);
    return DateFormat('MMM d').format(date) + getOrdinalSuffix(date.day);
  }

  String getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  Future<List<File>> processPickedImages(List<dynamic> _pickedImages) async {
    final tempDir = await getTemporaryDirectory();

    List<File> processedImages = _pickedImages.map((image) {
      if (image is File) {
        return image;
      } else if (image is Uint8List) {
        final tempFile = File(
            '${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png');
        tempFile.writeAsBytesSync(image);
        return tempFile;
      }
      throw Exception("Invalid image format");
    }).toList();

    debugPrint(
        'Processed images: ${processedImages.map((file) => file.path).toList()}');
    return processedImages;
  }
}
