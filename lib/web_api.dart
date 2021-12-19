
import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'util.dart';


class JsonResponse {
  bool success = false;
  String? message ='';
  int? statusCode;
  dynamic data;
  JsonResponse({required this.success, this.message, this.data, this.statusCode});
}


buildHeaders(Map<String, String> headers){
  var defaultHeaders = {
    HttpHeaders.userAgentHeader: '${Platform.operatingSystem}/${Platform.version}'
  };

  if(headers != null)
    defaultHeaders..addAll(headers);

  return defaultHeaders;
}


JsonResponse _processWebResponse(http.Response response, {bool jsonDecodeResponse=true}) {
  if (response.statusCode >=200 && response.statusCode < 400) {
    return JsonResponse(success: true, data: jsonDecodeResponse? jsonDecode(response.body) : response.body , statusCode: response.statusCode);
  }
  else if (response.statusCode == 401) {
    print('Received 401');
    return JsonResponse(
        success: false,
        message: "Invalid credentials",
      statusCode: response.statusCode
    );
  }
  else if (response.statusCode == 403) {
    print('Received 403');
    return JsonResponse(
        success: false,
        message: "Access denied",
        statusCode: response.statusCode
    );
  }
  else {
    print('Received ${response.statusCode}');
    print('BODY: ${response.body}');
    return JsonResponse(
        success: false,
        message: 'Server error!',
      statusCode: response.statusCode
    );
  }
}



Future<JsonResponse> fetch(String url, {required Map<String, String> headers, bool jsonDecodeResponse=true}) async {
  try {
    final response = await http.get(
        Uri.parse(url),
        headers: buildHeaders(headers)
    );
    print("Response received from $url");
    print("Transforming json to object $url");
    final json = _processWebResponse(
        response, jsonDecodeResponse: jsonDecodeResponse);
    print("Json to object done! $url");
    return json;
  }
  catch (ex) {

    //TODO: we need a way to report this
    print("There was problem posting. URL: $url EXCEPTION: $ex");

    return JsonResponse(success: false, message: "$ex", statusCode: null);
  }
}


Future<JsonResponse> post(String url, {required Map<String, String> headers, dynamic data, bool jsonDecodeResponse=true}) async {
  try {
    final response = await http.post(
        Uri.parse(url),
        body: data,
        headers: buildHeaders(headers)
    );

    return _processWebResponse(
        response, jsonDecodeResponse: jsonDecodeResponse);
  }
  catch(ex){

    //TODO: we need a way to report this
    print("There was problem posting. URL: $url Data: $data  EXCEPTION: $ex");

    return JsonResponse(success: false, message: "$ex");
  }
}

Future<JsonResponse> put(String url, {required Map<String, String> headers, dynamic data, bool jsonDecodeResponse=true}) async {
  try {
    final response = await http.put(
        Uri.parse(url),
        body: data,
        headers: buildHeaders(headers)
    );

    return _processWebResponse(
        response, jsonDecodeResponse: jsonDecodeResponse);
  }
  catch(ex){

    //TODO: we need a way to report this
    print("There was problem posting. URL: $url Data: $data  EXCEPTION: $ex");

    return JsonResponse(success: false, message: "$ex");
  }
}