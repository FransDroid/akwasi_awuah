import 'file_io.dart';

class UserLocalSettings {
  static const _localDataKey = '_localDataStore';

   int id = 0;
   String address;
   int isLogin = 0;
   String phoneNumber;
   String accessToken;
   String deviceToken;
   String emailAddress;
   String firstName;
   String lastName;
   String profileImage;
   String dateOfBirth;

   Map<String, dynamic>? _localData;

  UserLocalSettings(
      {this.id = 0,
      this.address = '',
      this.isLogin = 0,
      this.phoneNumber = '',
      this.deviceToken = '',
      this.accessToken = '',
      this.emailAddress = '',
      this.firstName = '',
      this.profileImage = '',
      this.dateOfBirth = '',
      this.lastName = ''});

  factory UserLocalSettings._fromJson(Map<String, dynamic> input) {


    final uStn = UserLocalSettings(
        id: input["id"],
        address: input["address"],
        isLogin: input["isLogin"],
        deviceToken: input["deviceToken"],
        phoneNumber: input["phoneNumber"],
        accessToken: input['accessToken'],
        emailAddress: input['emailAddress'],
        firstName: input['firstName'],
        profileImage: input['profileImage'],
        dateOfBirth: input['dateOfBirth'],
        lastName: input['lastName']);

    if (input.containsKey(_localDataKey)) {
      uStn._localData = input[_localDataKey];
    }

    return uStn;
  }

  Map<String, dynamic> _toJson() {
    return {
      "id": id,
      "address": address,
      "isLogin": isLogin,
      "deviceToken": deviceToken,
      "phone_number": phoneNumber,
      "access_token": accessToken,
      "email_address": emailAddress,
      "first_name": firstName,
      "profile_image": profileImage,
      "date_of_birth": dateOfBirth,
      "last_name": lastName,
      _localDataKey: _localData
    };
  }

  static Future<UserLocalSettings> fromDisk() async {
    final dataFromDisk = await FileStore.fromDisk('_awSettings.dat');
    if (dataFromDisk.isNotEmpty) {
      return UserLocalSettings._fromJson(dataFromDisk);
    } else {
      return UserLocalSettings();
    }
  }

  Future<bool> save() async {
    return await FileStore.save(_toJson(), '_awSettings.dat');
  }

  updateUserLocalData(dynamic data, String key) {
    _localData = _localData;
    _localData![key] = data;

    save();
  }

  dynamic getUserLocalData(String key) {
    if (_localData != null && _localData!.containsKey(key)) {
      return _localData![key];
    }
    return null;
  }
}

class RadioResponse {
  String? frequency;
  String? id;
  String? name;
  String? pic;
  String? status;
  String? url;

  RadioResponse({this.frequency, this.id, this.name, this.pic, this.status, this.url});

  factory RadioResponse.fromJson(Map<String, dynamic> json) {
    return RadioResponse(
      frequency: json['frequency'],
      id: json['id'],
      name: json['name'],
      pic: json['pic'],
      status: json['status'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frequency'] = this.frequency;
    data['id'] = this.id;
    data['name'] = this.name;
    data['pic'] = this.pic;
    data['status'] = this.status;
    data['url'] = this.url;
    return data;
  }
}

class AdsListModel {
  int? advert_type_id;
  int? company_id;
  String? end_date;
  int? id;
  String? image;
  String? start_date;
  String? title;
  String? video;
  String? website;

  AdsListModel({this.advert_type_id, this.company_id, this.end_date, this.id, this.image, this.start_date, this.title, this.video, this.website});

  factory AdsListModel.fromJson(Map<String, dynamic> json) {
    return AdsListModel(
      advert_type_id: json['advert_type_id'],
      company_id: json['company_id'],
      end_date: json['end_date'],
      id: json['id'],
      image: json['image'],
      start_date: json['start_date'],
      title: json['title'],
      video: json['video'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['advert_type_id'] = this.advert_type_id;
    data['company_id'] = this.company_id;
    data['end_date'] = this.end_date;
    data['id'] = this.id;
    data['image'] = this.image;
    data['start_date'] = this.start_date;
    data['title'] = this.title;
    data['video'] = this.video;
    data['website'] = this.website;
    return data;
  }
}

class TVResponse {
    String? app_update_status;
    String? id;
    String? status;
    String? tv_url;
    String? tv_status;
    String? updated_at;
    String? android_version;
    String? ios_version;

    TVResponse({this.app_update_status, this.id, this.status, this.tv_url,this.tv_status, this.updated_at, this.android_version, this.ios_version});

    factory TVResponse.fromJson(Map<String, dynamic> json) {
        return TVResponse(
            app_update_status: json['app_update_status'],
            id: json['id'],
            status: json['status'],
            tv_url: json['tv_url'],
          tv_status: json['tv_status'],
            updated_at: json['updated_at'],
          android_version: json['android_version'],
          ios_version: json['ios_version'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['app_update_status'] = this.app_update_status;
        data['id'] = this.id;
        data['status'] = this.status;
        data['tv_url'] = this.tv_url;
        data['tv_status'] = this.tv_status;
        data['updated_at'] = this.updated_at;
        data['android_version'] = this.android_version;
        data['ios_version'] = this.ios_version;
        return data;
    }
}

class SendMessage {
    String? code;
    String? message;

    SendMessage({this.code, this.message});

    factory SendMessage.fromJson(Map<String, dynamic> json) {
        return SendMessage(
            code: json['code'],
            message: json['message'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['message'] = this.message;
        return data;
    }
}