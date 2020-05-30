import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cats_api_test/enum/http_types.dart';

class HttpService {
  // Constructor
  static final String link = "http://research.solardigital.com.ua/api/v1/";

  HttpService._privateConstructor();

  static final HttpService _instance = HttpService._privateConstructor();

  static HttpService get instance => _instance;

  // Link building
  String buildUrl({@required String path, Map<String, dynamic> params}) {
    var returnUrl = link;
    returnUrl += path;

    if (params == null) {
      params = {};
    }
    String queryString = '';
    params.forEach((String key, dynamic value) {
      queryString += (queryString == '' ? '?' : '&') + key + '=' + value.toString();
    });

    print('URL => ${returnUrl + queryString}');

    return returnUrl + queryString;
  }

  Future<http.Response> request(
    HttpType type, {
    @required url,
    Map<String, dynamic> bodyParams,
    Map<String, dynamic> headers,
  }) async {
    Map<String, String> _headers = {};

    if (headers != null) {
      _headers = Map.from(headers);
    }
    
    try {
      switch (type) {
        case HttpType.GET:
          return await http.get(
            url,
            headers: _headers,
          ).then((http.Response resp) {
            return resp;
          });

        case HttpType.POST:
          return await http.post(
            url,
            headers: _headers,
            body: bodyParams,
          ).then((http.Response resp) {
            return resp;
          });

        case HttpType.PUT:
          return await http.put(
            url,
            headers: _headers,
            body: bodyParams,
          ).then((http.Response resp) {
            return resp;
          });

        case HttpType.DELETE:
          return await http.delete(
            url,
            headers: _headers,
          ).then((http.Response resp) {
            return resp;
          });
      }
    } catch (e) {
      // print(e.code.toString());
      // print(e.message.toString());
    }
    return null;
  }
}
