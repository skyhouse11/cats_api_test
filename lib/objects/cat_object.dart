import 'dart:convert';

import 'package:cats_api_test/util/cat_string_key.dart';

class Cat {
  final List<Map<String, dynamic>> breeds;
  final String id;
  final String url;
  final int width;
  final int height;

  Cat({
    this.breeds,
    this.id,
    this.url,
    this.width,
    this.height,
  });

  factory Cat.fromRawJson(String str) => Cat.fromJson(json.decode(str));

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      breeds: json[CatStringKey.breedsKey] ?? [],
      id: json[CatStringKey.idKey] ?? "",
      url: json[CatStringKey.urlKey] ?? "",
      width: json[CatStringKey.widthKey] ?? 0,
      height: json[CatStringKey.heightKey] ?? 0,
    );
  }
}
