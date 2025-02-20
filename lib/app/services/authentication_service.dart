import 'package:fleet_app/app/data/api_response.dart';
import 'package:fleet_app/app/services/api_services.dart';

class AuthenticationService {
  static Future<ApiResponse> loginService(Map<String, dynamic> data) {
    return ApiServices.authPostApi('/auth/login', data,
        transform: (dynamic res) {
      return res;
    });
  }
}
