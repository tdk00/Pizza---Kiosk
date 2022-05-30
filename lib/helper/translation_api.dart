import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/language_helper.dart';
import '../../../models/models.dart';
import 'config_helper.dart';

class TranslationApi {
  static Future<String> getTranslation( word ) async {

    var lang = await LanguageHelper.getLang();

    var base_url = await ConfigHelper.baseUrl();
    final uri =Uri.parse(base_url + 'Translation/translate/?word='+ word.toString() +'&lang=' + lang);
    print(uri);
    Response response = await get(uri);
    int statusCode = response.statusCode;
    String responseBody = response.body;
    if ( statusCode == 200 ) {
      return responseBody;
    }

    return "";
  }
}