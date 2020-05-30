import 'package:cats_api_test/util/cat_string_key.dart';
import 'package:flutter/material.dart';

import 'package:cats_api_test/util/static_text.dart';

class DescriptionView extends StatelessWidget {
  const DescriptionView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    print("args => $args");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          StaticText.descViewTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(16.0),
              child: Image.network(
                args[CatStringKey.urlKey],
                height: 200,
                width: 200,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: Text(
                "Height => ${args[CatStringKey.heightKey]}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: Text(
                "Width => ${args[CatStringKey.widthKey]}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
