import 'dart:io';

import 'package:akwasi_awuah/util.dart';
import 'package:package_info/package_info.dart';

import 'config.dart';
import 'models.dart';
import 'web_api.dart' as http;

class ServicesLibrary {
  final AppSettings _settings;
  final Future<UserLocalSettings?> _userLocalSettings;

  ServicesLibrary(this._settings, this._userLocalSettings);

  get authorizationHeader2 =>
      {
        "Accept": "application/json"
      };

  get authorizationHeader async {
    var token =  (await _userLocalSettings)!.accessToken;
    if(token.isEmpty){
        token = _settings.apiAccessToken;
    }
    return {
      "Authorization": "Bearer $token",
      "content-type": "application/json"
    };
  }

  Future<Map<String, dynamic>> getVersionSupportInformation() async {
    final appInfo = await PackageInfo.fromPlatform();
    final appKey = Platform.isAndroid ? "kuodroid" : "kuoios";
    final response = await http.fetch(
        "${_settings.apiBaseUrl}/api/versioning/app/$appKey/version/${appInfo.version}/",
        headers: await authorizationHeader);

    if (response.success) {
      logWithTime("Successfully fetched version information: ${response.data}");
      return {
        "success": true,
        "thisVersionSupported": response.data["supported"],
        "hasUpdates": response.data["updatesAvailable"],
      };
    } else {
      logWithTime("Unable to get version info: ${response.message} ");
      return {"success": false, "error": response.message};
    }
  }

  Future<List<RadioResponse>> getRadio() async {
    List<RadioResponse> result = <RadioResponse>[];
    var response = await http.fetch("${_settings.apiBaseUrl}/app/api/radio.php",
        headers: authorizationHeader2);
    if (response.success) {
      for (final c in response.data) {
        result.add(RadioResponse.fromJson(c));
      }
    }
    else {
      logWithTime("Error while trying to load data");
    }
    return result;
  }

  Future<TVResponse?> getTV() async {
    var response = await http.fetch("${_settings.apiBaseUrl}/app/api/tv.php",
        headers: authorizationHeader2);
    if (response.success) {
      return TVResponse.fromJson(response.data);
    }
    else {
      logWithTime("Error while trying to load data");
    }
    return null;
  }

  Future<List<AdsListModel>> getAdList(url) async {
    List<AdsListModel> result = <AdsListModel>[];
    var response = await http.fetch(
        url,headers: authorizationHeader2);
    if (response.success) {
      for (final c in response.data) {
        result.add(AdsListModel.fromJson(c));
      }
    }
    else {
      print("Error while trying to load data");
    }
    return result;
  }
}
