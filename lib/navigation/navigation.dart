import 'package:flutter/material.dart';

class Navigation<T, U> {
  Navigation.privateConstructor();
  static final Navigation instance = Navigation.privateConstructor();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigate(String path,{Object? args}) {
    return navigatorKey.currentState?.pushNamed(path,arguments: args);
  }

  Future<dynamic>? navigateAndReplace(String path,{Object? args}) {
    return navigatorKey.currentState?.pushReplacementNamed(path,arguments: args);
  }

  Future<dynamic>? navigateAndRemoveUntil(String path, {Object? args}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(path,(Route<dynamic> route) => false, arguments: args);
  }

  void goBack({Object? args}) {
    if(navigatorKey.currentState?.canPop() ?? false){
      return navigatorKey.currentState?.pop(args);
    }
  }
}
