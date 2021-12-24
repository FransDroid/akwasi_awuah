
import 'package:akwasi_awuah/service.dart';
import 'package:akwasi_awuah/util.dart';
import 'package:flutter/material.dart';

import 'config.dart';
import 'models.dart';

class ViewController extends ChangeNotifier {
  final AppSettings _settings;

  UserLocalSettings? _cachedUserSettings;
  Future<UserLocalSettings>? _mySettings;
  bool? _versionSupported;
  bool? _hasPendingUpdates;

  Future<UserLocalSettings?> get mySettings async {
    _mySettings ??= UserLocalSettings.fromDisk();
    _cachedUserSettings = await _mySettings;

    return _mySettings;
  }

  Future<bool?> get isVersionSupported async {
    if (_versionSupported == null) {
      final response = await _servicesLibrary.getVersionSupportInformation();
      if (response['success']) {
        _versionSupported = response['thisVersionSupported'];
        _hasPendingUpdates = response['hasUpdates'];
      } else {
        _versionSupported = true;
        _hasPendingUpdates = false;
      }
    }

    return _versionSupported;
  }

  ViewController(this._settings);


  ServicesLibrary get _servicesLibrary => ServicesLibrary(_settings, mySettings);

  final Map<String, dynamic> _notifications={};
  Future<List<dynamic>> get notificationMessages async{
    return _notifications.values.toList();

    //TODO: implement notifications persistence
//    final settings = await _mySettings;
//    return settings.getUserLocalData('notifications') ?? [];
  }

  Future<List<dynamic>> get unreadNotificationMessages async{
    return _notifications.values.where((n)=>n['seen']==null || n['seen']==false).toList();
  }


  Future<bool> saveNotification(dynamic notification) async{
    final String key = "${notification['title']}${notification['body']}${formatDateTime(notification['time'])}";
    if(!_notifications.containsKey(key)) {
      _notifications [key] = notification;

      notifyListeners();

      return true;
    }
    logWithTime("Notification saved in memory $notification");

    return false;

    //TODO: Implement a better way to persist messages
    //final settings = await _mySettings;
    //settings.updateUserLocalData(notifications, 'notifications');
  }


  logOut() async {
    final settings = await mySettings;

    settings!.accessToken = '';
    settings.isLogin = 0;
    
    return await settings.save();
  }

  Future<List<RadioResponse>> getRadio() async {
    return _servicesLibrary.getRadio();
  }

  Future<TVResponse?> getTV() async {
    return _servicesLibrary.getTV();
  }

  Future<List<AdsListModel>> getAdList(url) async {
    return _servicesLibrary.getAdList(url);
  }

  Future<TVResponse?> getUpdate() async {
    return _servicesLibrary.getUpdate();
  }

  Future<SendMessage?> sendMail(email,name,message) async {
    return _servicesLibrary.sendMail(email,name,message);
  }

}


