import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'navigation/navigation.dart';
import 'navigation/route_path.dart';
import 'navigation/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getPermission();
  setupLogging();
  runApp(const Main());
}

void setupLogging() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    if (kDebugMode) {
      log('${rec.level.name}: ${rec.time}: ${rec.message}');
    }
  });
}

void getPermission() async {
  await Permission.phone.request();
  await Permission.manageExternalStorage.request();
  await Permission.storage.request();
}

class Main extends StatelessWidget {
  const Main({super.key});

  void _setSystemUiOverlay() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    _setSystemUiOverlay();
    return MaterialApp(
      title: "Call Recorder",
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: Navigation.instance.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: RoutePath.splashRoute,
    );
  }
}
