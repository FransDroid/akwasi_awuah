
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../models.dart';
import '../view_controller.dart';
import 'home.dart';

class SplashPage extends StatefulWidget {
  static const route = "splash-page";

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.popAndPushNamed(context, MyHomePage.route);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/splash.jpg'), fit: BoxFit.fitWidth),
        ));
  }
}
