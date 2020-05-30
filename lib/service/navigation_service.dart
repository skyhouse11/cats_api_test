import 'package:flutter/material.dart';

class NavigationService {
  // Constructor
  NavigationService._privateConstructor();

  static final NavigationService _instance =
      NavigationService._privateConstructor();

  static NavigationService get instance => _instance;

  // GlobalKey
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  // Main functionality
  void navigateTo(
    String routeName, {
    bool replace = false,
    Map<String, dynamic> args,
  }) async {
    if (replace) {
      await _navigatorKey.currentState.pushReplacementNamed(
        routeName,
        arguments: args ?? {},
      );
    } else {
      await _navigatorKey.currentState.pushNamed(
        routeName,
        arguments: args,
      );
    }
  }

  void pop() async {
    _navigatorKey.currentState.pop();
  }
}
