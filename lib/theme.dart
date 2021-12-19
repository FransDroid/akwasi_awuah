
import 'package:akwasi_awuah/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config.dart';

final _colorScheme =ThemeData.light().colorScheme.copyWith(
    primary: const Color(0xFF14A3E7),//0d519a
    secondary: const Color(0xFF2094da),
    background:const Color(0xffFFFBF2),
    surface: const Color(0xffF5F4EF),
    primaryVariant: const Color(0xffefd283),
);

const textTheme = TextTheme(
    headline5: TextStyle(
        fontSize: 18,
        color: Colors.black87,
        fontWeight: FontWeight.bold
    ),
    headline6: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        color: Colors.black87
    ),
    subtitle2: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.grey
    ),
    bodyText2: TextStyle(
        color: Colors.black45,
        fontWeight: FontWeight.normal,
        fontSize: 11
    )
);

const textThemeDark = TextTheme(
    headline5: TextStyle(
        fontSize: 18,
        color: Colors.black87,
        fontWeight: FontWeight.bold
    ),
    headline6: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        color: Colors.black87
    ),
    subtitle2: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.grey
    ),
    bodyText2: TextStyle(
        color: Colors.black45,
        fontWeight: FontWeight.normal,
        fontSize: 11
    )
);

final appTheme= ThemeData.light().copyWith(
  colorScheme: _colorScheme,
  primaryColor:_colorScheme.primary,
  scaffoldBackgroundColor: _colorScheme.background,
  appBarTheme: ThemeData.light().appBarTheme.copyWith(
      color: _colorScheme.surface,
      iconTheme: const IconThemeData(
          color: Colors.white
      ), systemOverlayStyle: SystemUiOverlayStyle.light
  ),
  primaryTextTheme: textTheme,
);

const appCupertinoThemeLight = CupertinoThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF14A3E7),
);

const appCupertinoThemeDark = CupertinoThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF14A3E7),
  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(color: Colors.white)
  )
);