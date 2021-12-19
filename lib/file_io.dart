import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStore{

  static Future<Map<String,dynamic>> fromDisk(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    if(await file.exists()) {
      final jsonStrb64 = await file.readAsString();

      if (jsonStrb64.isNotEmpty) {
        final jsonStr = utf8.decode(base64.decode(jsonStrb64));
        return jsonDecode(jsonStr);
      }
    }
    return {};
  }

  static Future<bool> save(Map jsonData, String fileName) async{
    final jsonStr=jsonEncode(jsonData);
    final jsonStrb64 = base64.encode(utf8.encode(jsonStr));

    if(jsonStrb64.isEmpty)
      return false;

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');

    file.writeAsStringSync('$jsonStrb64');

    return true;
  }
}