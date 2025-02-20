import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:uuid/uuid.dart';

// Import geolocator packages conditionally
import 'package:geolocator/geolocator.dart'
    if (dart.library.js) 'package:geolocator_web/geolocator_web.dart';

class DeviceInfoController extends GetxController {
  var deviceId = ''.obs;
  var ipAddress = ''.obs;
  var deviceOs = ''.obs;
  var deviceName = ''.obs;
  var latitude = ''.obs;
  var longitude = ''.obs;

  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  final Uuid _uuid = const Uuid();
  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;

  @override
  void onInit() {
    super.onInit();
    getDeviceInfo();
    getIPAddress();
    getUserLocation();
  }

  Future<void> getDeviceInfo() async {
    try {
      if (kIsWeb) {
        deviceOs.value = "web";
        deviceId.value = _uuid.v4();
        deviceName.value = "Web Browser";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
        deviceOs.value = 'iOS';
        deviceId.value = iosInfo.identifierForVendor ?? "";
        deviceName.value = iosInfo.name;
      } else if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
        deviceOs.value = 'Android';
        deviceId.value = androidInfo.id;
        deviceName.value = androidInfo.model;
      } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
        WebBrowserInfo webInfo = await _deviceInfoPlugin.webBrowserInfo;
        deviceOs.value = Platform.operatingSystem;
        deviceId.value = _uuid.v4(); // No unique ID, so generate one
        deviceName.value = webInfo.userAgent ?? "Desktop";
      }
    } catch (e) {
      debugPrint("Error getting device info: $e");
    }
  }

  Future<void> getIPAddress() async {
    try {
      var ip = IpAddress(type: RequestType.json);
      dynamic data = await ip.getIpAddress();
      ipAddress.value = data.toString();
    } catch (e) {
      debugPrint("Error getting IP address: $e");
    }
  }

  Future<void> getUserLocation() async {
    try {
      bool serviceEnabled = await _geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint("Location services are disabled.");
        return;
      }

      LocationPermission permission = await _geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await _geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint("Location permission denied.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint("Location permission permanently denied.");
        return;
      }

      Position position = await _geolocator.getCurrentPosition(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high));
      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
  }
}
