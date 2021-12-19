import 'package:akwasi_awuah/pages/contact_us.dart';
import 'package:akwasi_awuah/pages/live_tv.dart';
import 'package:akwasi_awuah/theme.dart';
import 'package:akwasi_awuah/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import '../models.dart';
import '../util.dart';
import '../view_controller.dart';
import 'live_radio.dart';

class MyHomePage extends StatefulWidget {
  static const route = "/";

  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _currentIndex = 0;
  late ViewController model;
  late PlatformTabController tabController;
  late List<Widget> tabs;
  static final titles = ['Live Radio', 'Live TV', 'Contacts'];

  @override
  void initState() {
    super.initState();
    tabController = PlatformTabController(
      initialIndex: 0,
    );
    tabs = [const LiveRadio(), const LiveTV(), const ContactUs()];
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewController>(context);

    return FutureBuilder<UserLocalSettings?>(
        future: model.mySettings,
        builder: (context, awaitedData) {
          if (awaitedData.hasData) {
            return PlatformTabScaffold(
              iosContentPadding: true,
              tabController: tabController,
              appBarBuilder: (_, index) =>
                  buildAppBar(context, title: Strings.appName),
              bodyBuilder: (context, index) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(child: child, scale: animation);
                },
                child: IndexedStack(
                  index: index,
                  children: tabs,
                ),
              ),
              items: [
                BottomNavigationBarItem(
                  label: titles[0],
                  icon: Icon(context.platformIcons.musicNote),
                ),
                BottomNavigationBarItem(
                  label: titles[1],
                  icon: Icon(context.platformIcons.videoCamera),
                ),
                BottomNavigationBarItem(
                  label: titles[2],
                  icon: Icon(context.platformIcons.phoneSolid),
                ),
              ],
            );
          } else if (awaitedData.hasError) {
            return PlatformScaffold(
                body: createErrorWidget(error: awaitedData.error.toString()));
          } else {
            return PlatformScaffold(body: createProgressWidget(context));
          }
        });
  }
}
