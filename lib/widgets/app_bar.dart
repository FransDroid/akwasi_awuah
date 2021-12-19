
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../config.dart';

PlatformAppBar buildAppBar(BuildContext context, {required String title,
  bool showProfileButton = false}) {
  const iconSize = 28.0;
  return PlatformAppBar(
    backgroundColor: Theme.of(context).primaryColor,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PlatformText(title, style: Theme
            .of(context)
            .primaryTextTheme
            .headline5!.copyWith(color: Colors.white))
      ],
    ),
    trailingActions: <Widget>[
      showProfileButton ? PlatformIconButton(
        icon: const Icon(Icons.account_circle, size: iconSize),
        onPressed: () {
          //Navigator.pushNamed(context, ProfilePage.route);
        },
      ) : Container(),

    ],
  );
}