import 'dart:async';
import 'dart:convert';
import 'package:flutter_app_desktop/helper/language_helper.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/config_helper.dart';
import '../../../models/models.dart';

class MenuProductsApi {

  static Future<List<Category>> getCategories() async {

    var lang = await LanguageHelper.getLang();
    var base_url = await ConfigHelper.baseUrl();
    final uri =Uri.parse(base_url + 'MenuScreen/category_list/?lang=' + lang);

    Response response = await get(uri);
    int statusCode = response.statusCode;
    String responseBody = response.body;

    List<Category> categoriesList = [];

    if ( statusCode == 200 ) {
      for (final category in jsonDecode(responseBody)) {

        categoriesList.add(
            Category( int.parse( category['id'] ), category['name'], category['image'], int.parse( category['is_default'] ) )
          );

      }
    }

      return categoriesList;
  }


  static Future<List> getProducts( id ) async {
    var lang = await LanguageHelper.getLang();
    var base_url = await ConfigHelper.baseUrl();
    final uri =Uri.parse(base_url + 'MenuScreen/products_list_by_category/?category_id='+ id.toString() +'&lang=' + lang);

    Response response = await get(uri);
    int statusCode = response.statusCode;
    String responseBody = response.body;

    List<Product> productsList = [];

    if ( statusCode == 200 ) {
      for (final product in jsonDecode(responseBody)) {
        productsList.add(
            Product( int.parse( product['id'] ), int.parse( product['category_id'] ), product['name'], product['image'], [] )
        );

      }
    }

    return productsList;
  }

  static updateShoppingCartProductCounts ( shoppingCartProductList ) async {

    final prefs = await SharedPreferences.getInstance();
    var session_id = prefs.getString('session_id') ;
    var base_url = await ConfigHelper.baseUrl();
    final uri =Uri.parse(base_url + 'MenuScreen/update_shopping_cart_product_counts');
    var body = json.encode({
      "session_id" : session_id,
      "product_list": jsonEncode( shoppingCartProductList )
    });
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };

    Response response = await http.post(uri, body: body, headers: headers);
    int statusCode = response.statusCode;
    String responseBody = response.body;

    List<Extra> extrasList = [];

    if ( statusCode == 200 ) {

    }

  }


}
