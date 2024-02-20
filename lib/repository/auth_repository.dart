import 'package:mvvm_flutter/data/network/base_api_service.dart';
import 'package:mvvm_flutter/data/network/network_api_service.dart';
import 'package:mvvm_flutter/res/app_url.dart';

class AuthRepository {
  BaseApiService _apiService = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.getPostApiResponse(AppUrl.loginEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
