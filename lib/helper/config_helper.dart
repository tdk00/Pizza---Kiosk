import 'dart:io';

import 'package:path_provider/path_provider.dart';


class ConfigHelper{
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    print(directory.path);
    return directory.path;
  }
  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/PizzaProgramFiles/baseUrl.txt');
  }

  static Future<String> readBaseUrl() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'http://localhost/kingsmart_ci/';
    }
  }

   static baseUrl() async{
    var base_url = await readBaseUrl();
    return base_url;
  }

}