import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/config_helper.dart';

class OrderApi {

  static addOrder ( totalAmount, payment_type ) async {
    final prefs = await SharedPreferences.getInstance();
    var session_id = prefs.getString('session_id') ;
    var is_takeaway = prefs.getInt('is_takeaway') ;
    var base_url = await ConfigHelper.baseUrl();
    final uri =Uri.parse(base_url + 'Orders/add_order');
    var body = json.encode({ "total_amount": totalAmount, "payment_type" : payment_type, "session_id" : session_id, "is_takeaway" : is_takeaway });
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };

    Response response = await http.post(uri, body: body, headers: headers);
    int statusCode = response.statusCode;
    String responseBody = response.body;


    if ( statusCode == 200 ) {
       print( jsonDecode(responseBody)["orderObj"] );
        return { 'orderId' : jsonDecode(responseBody)["orderId"], 'orderNumber' :  jsonDecode(responseBody)["orderNumber"] };
    }
    else {
      return { 'orderId' : 0, 'orderNumber' :  0 };
    }

  }

}

