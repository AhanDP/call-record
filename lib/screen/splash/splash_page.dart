import 'package:flutter/material.dart';
import '../../navigation/navigation.dart';
import '../../navigation/route_path.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), (){
      Navigation.instance.navigateAndRemoveUntil(RoutePath.homeRoute);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.blue,
        body: SafeArea(
          top: false,
          bottom: true,
          child: Column(
            children: [
              Spacer(),
              Text(
                "Call Recorder",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Spacer(),
              Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
              ),
              SizedBox(height: 50)
            ],
          ),
        ));
  }
}
