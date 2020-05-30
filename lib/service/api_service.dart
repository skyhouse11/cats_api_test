import 'package:http/http.dart' as http;

import 'package:cats_api_test/service/http_service.dart';
import 'package:cats_api_test/enum/http_types.dart';

class ApiService {
  // Constructor
  ApiService._privateConstructor();

  static final ApiService _instance = ApiService._privateConstructor();

  static ApiService get instance => _instance;

  HttpService _httpService = HttpService.instance;

  static const String _apiKey = "1fe24f18-98d5-427d-bf0c-875148d7e205";

  /// Receives response with json containing cats
  Future<http.Response> receivePageOfCats({int page}) async {
    return await _httpService.request(
      HttpType.GET,
      headers: {
        "x-api-key": _apiKey,
      },
      url: _httpService.buildUrl(
        path: "images/search",
        params: {
          "page": page,
          "limit": 50,
          "mime_types": "png",
          "size": "small",
        },
      ),
    );
  }
}
