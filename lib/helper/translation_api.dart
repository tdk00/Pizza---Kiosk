import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/language_helper.dart';
import '../../../models/models.dart';

class TranslationApi {
  static Future<String> getTranslation( word ) async {

    var lang = await LanguageHelper.getLang();

    final uri = Uri.parse('http://localhost/kingsmart_ci/Translation/translate/?word='+ word.toString() +'&lang=' + lang);
    Response response = await get(uri);
    int statusCode = response.statusCode;
    String responseBody = response.body;
    if ( statusCode == 200 ) {
      return responseBody;
    }

    return "";
  }
}