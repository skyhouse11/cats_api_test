import 'package:cats_api_test/bloc/bloc.dart';
import 'package:cats_api_test/bloc/event/cat_object_event.dart';
import 'package:cats_api_test/bloc/transition/transition.dart';
import 'package:cats_api_test/service/navigation_service.dart';
import 'package:cats_api_test/util/route_names.dart';
import 'package:cats_api_test/view/description_view.dart';
import 'package:cats_api_test/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        RouteNames.homeLink: (context) => BlocProvider(
              create: (context) => CatObjectBloc()
                ..add(
                  Fetch(),
                ),
              child: HomeView(),
            ),
        RouteNames.descriptionLink: (context) => DescriptionView(),
      },
    );
  }
}
