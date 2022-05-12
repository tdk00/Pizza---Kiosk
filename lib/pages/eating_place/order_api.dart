import 'dart:async';
import 'dart:convert';
import 'package:flutter_app_desktop/helper/language_helper.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/models.dart';

class OrderApi {

  static addOrder ( totalAmount, payment_type ) async {
    final prefs = await SharedPreferences.getInstance();
    var session_id = prefs.getString('session_id') ;
    var is_takeaway = prefs.getInt('is_takeaway') ;
    final uri = Uri.parse('http://localhost/kingsmart_ci/Orders/add_order');
    var body = json.encode({ "total_amount": totalAmount, "payment_type" : payment_type, "session_id" : session_id, "is_takeaway" : is_takeaway });
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };

    Response response = await http.post(uri, body: body, headers: headers);
    int statusCode = response.statusCode;
    String responseBody = response.body;


    if ( statusCode == 200 ) {
        return true;
    }
    else {
      return false;
    }

  }


}
