import 'package:fleet_app/app/data/api_response.dart';
import 'package:fleet_app/app/data/login_payload.dart';
import 'package:fleet_app/app/data/vehicle_infographic.dart';
import 'package:fleet_app/app/data/vehicle_payload.dart';
import 'package:fleet_app/app/services/api_services.dart';

class RemoteService {
  static Future<ApiResponse<LoginPayload>> loginService(
      Map<String, dynamic> data) {
    return ApiServices.authPostApi('/auth/login', data,
        transform: (dynamic res) {
      return LoginPayload.fromJson(res);
    });
  }

  static Future<ApiResponse<VehicleInfographic>>
      getVehicleInfographicService() {
    return ApiServices.getApi('/vehicle/infographics', {}, useToken: true,
        transform: (dynamic res) {
      return VehicleInfographic.fromJson(res);
    });
  }

  static Future<ApiResponse<VehiclePayload>> getVehicleService(
      {required  Map<String, dynamic> params}) {
    
    return ApiServices.getApi('/vehicle/all', {},
        useToken: true, params: params, transform: (dynamic res) {
      return VehiclePayload.fromJson(res);
    });
  }

  static Future<ApiResponse<VehiclePayload>> getVehicleDetailService(
      {required String id}) {
    Map<String, dynamic> params = {'vehicle_id': id};
    return ApiServices.getApi('/vehicle/all', {},
        useToken: true, params: params, transform: (dynamic res) {
      return VehiclePayload.fromJson(res);
    });
  }

  static Future<ApiResponse> createDriverService(Map<String, dynamic> data) {
    return ApiServices.postApi('/driver/create', data,
        transform: (dynamic res) {
      return res;
    });
  }

  static Future<ApiResponse> createTeamService(Map<String, dynamic> data) {
    return ApiServices.postApi('/team/create-update', data,
        transform: (dynamic res) {
      return res;
    });
  }

  static Future<ApiResponse> createVehicleService(Map<String, dynamic> data) {
    return ApiServices.postApi('/vehicle/create', data,
        transform: (dynamic res) {
      return res;
    });
  }

  static Future<ApiResponse> uploadImageService(Map<String, dynamic> data) {
    return ApiServices.postApi('/vehicle/upload-images', data,
        transform: (dynamic res) {
      return res;
    });
  }
}
