
import 'dart:io';

import 'package:akwasi_awuah/view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import 'config.dart';

class Helper {
  static String? validatePhone(String value) {
    if (value.trim().isEmpty || value.length < 10) {
      return 'Invalid Phone Number';
    }
    return null;
  }

  static String? validateName(String value) {
    if (value.trim().isEmpty) {
      return 'Invalid Name';
    }
    return null;
  }

  static launchURL(url) async {
    print('hell no $url');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      if (await canLaunch('http://$url')) {
        await launch('http://$url');
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  static String? validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (value.isEmpty || !regex.hasMatch(value)) {
      return 'Invalid Email Address';
    } else {
      return null;
    }
  }

  static bool isEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (value.isEmpty || !regex.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  static String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  static Future<bool>? onWillPop() {
    return null;
  }

  static checkUpdate(BuildContext context) async {

    ViewController model = Provider.of<ViewController>(context,listen: false);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    final update = await model.getTV();
      if(update!.app_update_status == "1"){
        if(Platform.isAndroid ? update.android_version != version : update.ios_version != version) {
          showPlatformDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: PlatformAlertDialog(
                    title: const Text('Update App?'),
                    content: Text(
                        'A new version of $appName is available!'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('UPDATE NOW'),
                        onPressed: () {
                          Navigator.pop(context);
                          Platform.isAndroid
                              ? StoreRedirect.redirect()
                              : StoreRedirect.redirect(iOSAppId: '1480946758');
                        },
                      ),
                    ],
                  ),
                );
              });
        }
      }
  }
}