import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      return responseJson(response);
    } on SocketException {
      throw InternetException("NO Internet!");
    }
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      return responseJson(response);
    } on SocketException {
      throw InternetException("NO Internet!");
    }
  }

  dynamic responseJson(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        throw BadRequestException("Bad request!");
      default:
        throw InternetException(
            "${response.statusCode} : ${response.reasonPhrase}");
    }
  }
}
