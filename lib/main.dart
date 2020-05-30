import 'package:cats_api_test/bloc/bloc.dart';
import 'package:cats_api_test/bloc/event/cat_object_event.dart';
import 'package:cats_api_test/bloc/transition/transition.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => CatObjectBloc()
          ..add(
            Fetch(),
          ),
        child: HomeView(),
      ),
    );
  }
}
