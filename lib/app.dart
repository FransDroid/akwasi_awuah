import 'package:akwasi_awuah/pages/home.dart';
import 'package:akwasi_awuah/pages/splash.dart';
import 'package:akwasi_awuah/theme.dart';
import 'package:akwasi_awuah/view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'config.dart';


class MyApp extends StatelessWidget {
  final Environments _environment;

   const MyApp(this._environment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const appName = Strings.appName;
    var initialRoute = SplashPage.route;
    var routes = {
      SplashPage.route: (context) => const SplashPage(),
      MyHomePage.route: (context) => const MyHomePage(),
    };

    return ChangeNotifierProvider(
      create: (context) =>
          ViewController(AppSettings.byEnvironment(_environment)),
      child: PlatformApp(
      material: (_, __) => MaterialAppData(
        theme: appTheme,
        title: appName,
        initialRoute: initialRoute,
        debugShowCheckedModeBanner: false,
        routes: routes,
            ),
          cupertino: (_, __) => CupertinoAppData(
          theme: appCupertinoTheme,
          title: appName,
          initialRoute: initialRoute,
          debugShowCheckedModeBanner: false,
          routes: routes,
        ),
      )
    );
  }
}
