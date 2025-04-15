import 'dart:developer';
import 'package:call_recorder/screen/home/home_page.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import '../screen/splash/splash_page.dart';
import 'route_path.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  log('Route Name => ${settings.name}');
  log('Route Arguments  => ${settings.arguments}');

  switch (settings.name) {
    case RoutePath.splashRoute:
      return MaterialPageRoute(builder: (context) => const SplashPage());
    case RoutePath.homeRoute:
      return MaterialPageRoute(builder: (context) => const HomePage());
    /*case RoutePath.homeRoute:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case RoutePath.updateSwipeRoute:
      var homeList = settings.arguments;
      if (homeList is HomeList) {
        return MaterialPageRoute(
            builder: (context) => UpdateSwipeScreen(homeList: homeList));
      } else {
        return errorPageRoute(settings);
      }
    case RoutePath.updateCardRoute:
      var homeList = settings.arguments;
      if (homeList is HomeList) {
        return MaterialPageRoute(
            builder: (context) => UpdateCardScreen(homeList: homeList));
      } else {
        return errorPageRoute(settings);
      }*/
    /*case RoutePath.verifyOtp:
      Map<String, dynamic> arguments =
          settings.arguments as Map<String, dynamic>;
      if (arguments['mobile'] == null && arguments['dialCode'] == null) {
        return errorPageRoute(settings);
      }
      return MaterialPageRoute(
          builder: (context) => VerifyOtpScreen(
              mobile: arguments['mobile'], dialCode: arguments['dialCode']));*/
    default:
      return errorPageRoute(settings);
  }
}

MaterialPageRoute<dynamic> errorPageRoute(RouteSettings settings) {
  if (foundation.kReleaseMode) {
    return MaterialPageRoute(builder: (context) => const SizedBox());
  } else {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/error_route.png", height: 150),
              const SizedBox(height: 20),
              const Text('Oops!',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Text("Page (${settings.name}) not found",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 18))
            ],
          ),
        ),
      ),
    );
  }
}
