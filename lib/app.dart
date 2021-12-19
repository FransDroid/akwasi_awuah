import 'package:akwasi_awuah/pages/home.dart';
import 'package:akwasi_awuah/pages/splash.dart';
import 'package:akwasi_awuah/theme.dart';
import 'package:akwasi_awuah/view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'config.dart';

class MyApp extends StatefulWidget {
  final Environments _environment;

  const MyApp(this._environment, {Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  Brightness? _brightness;

  Brightness? get brightness => _brightness;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _brightness = WidgetsBinding.instance?.window.platformBrightness;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        _brightness = WidgetsBinding.instance?.window.platformBrightness;
      });
    }
    super.didChangePlatformBrightness();
  }

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
            ViewController(AppSettings.byEnvironment(widget._environment)),
        child: PlatformApp(
          material: (_, __) => MaterialAppData(
            theme: appTheme,
            title: appName,
            initialRoute: initialRoute,
            debugShowCheckedModeBanner: false,
            routes: routes,
          ),
          cupertino: (_, __) => CupertinoAppData(
            theme: _brightness == Brightness.dark ? appCupertinoThemeDark : appCupertinoThemeLight,
            title: appName,
            initialRoute: initialRoute,
            debugShowCheckedModeBanner: false,
            routes: routes,
          ),
        )
    );
  }
}


/*
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
*/
