import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mvvm_flutter/data/app_exception.dart';
import 'package:mvvm_flutter/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url,dynamic data) async {
    dynamic responseJson;

    try {
      Response response =
          await http.post(Uri.parse(url),body: data).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException(
            'Error occured while communicating with server with status code ${response.statusCode}');
    }
  }
}
