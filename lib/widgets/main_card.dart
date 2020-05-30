import 'package:cats_api_test/service/navigation_service.dart';
import 'package:cats_api_test/util/cat_string_key.dart';
import 'package:cats_api_test/util/route_names.dart';
import 'package:flutter/material.dart';

import 'package:cats_api_test/bloc/data_object/cat_object.dart';

class MainCard extends StatelessWidget {
  final Cat cat;

  const MainCard({this.cat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationService.instance.navigateTo(
          RouteNames.descriptionLink,
          args: {
            CatStringKey.idKey: cat.id,
            CatStringKey.urlKey: cat.url,
            CatStringKey.heightKey: cat.height,
            CatStringKey.widthKey: cat.width,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black12,
        ),
        height: 100,
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(cat.url),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text("Cat ID => ${cat.id}"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
