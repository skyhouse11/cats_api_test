import 'package:http/http.dart' as http;

import 'package:cats_api_test/service/http_service.dart';
import 'package:cats_api_test/enum/http_types.dart';

class ApiService {
  // Constructor
  ApiService._privateConstructor();

  static final ApiService _instance = ApiService._privateConstructor();

  static ApiService get instance => _instance;

  HttpService _httpService = HttpService.instance;

  /// Receives response with json containing cats
  Future<http.Response> receivePageOfCats({int page}) async {
    return await _httpService.request(
      HttpType.GET,
      url: _httpService.buildUrl(
        path: "images/search",
        params: {
          "page": page,
          "limit": 50,
        },
      ),
    );
  }
}
