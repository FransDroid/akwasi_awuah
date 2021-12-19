
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
}