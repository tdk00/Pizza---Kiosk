import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
class LanguageHelper {
    static Future<String> getLang() async {
    var lang = await getShared();
    if( lang != "az" && lang != "ru" && lang !="en")
      {
        lang = "az";
      }
    return lang;

  }

    static getShared() async{
     var prefs =  await SharedPreferences.getInstance();
     var lang = prefs.get('lang');
      return lang;
    }
}