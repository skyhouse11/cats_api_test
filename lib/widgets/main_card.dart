import 'package:cats_api_test/bloc/data_object/cat_object.dart';
import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Cat cat;

  const MainCard({this.cat});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: <Widget>[
          Image.network(
            cat.url,
            height: 250,
            fit: BoxFit.contain,
          )
        ],
      ),
    );
  }
}
