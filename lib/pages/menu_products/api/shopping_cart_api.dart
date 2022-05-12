import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/language_helper.dart';
import '../../../models/models.dart';

class ShoppingCartApi {
  static Future<List<ShoppingCartProduct>> getShoppingCartProducts() async {

    var lang = await LanguageHelper.getLang();
    var prefs =  await SharedPreferences.getInstance();
    var session_id = prefs.get('session_id');

    final uri = Uri.parse('http://localhost/kingsmart_ci/MenuScreen/shopping_cart/?session_id='+ session_id.toString() +'&lang=' + lang);
    Response response = await get(uri);
    int statusCode = response.statusCode;
    String responseBody = response.body;
    List<ShoppingCartProduct> productsList = [];
    if ( statusCode == 200 ) {

      for (final product in jsonDecode(responseBody)) {
        productsList.add(
            ShoppingCartProduct(
                int.parse( product['shopping_cart_product_id'] ),
                int.parse( product['product_id'] ),
                int.parse( product['size_id'] ),
                int.parse( product['product_count'] ),
                product['session_id'],
                product['name'],
                product['size_name'],
                product['image'],
                product['barkod'],
                double.parse( product['price_including_extras'].toString() ),
                double.parse( product['total'].toString() )
            )
        );

      }
    }

    return productsList;
  }

  static removeShoppingCartItem( shopping_cart_product_id )  async {



    var prefs =  await SharedPreferences.getInstance();
    var session_id = prefs.get('session_id');

    print ( session_id );
    final uri = Uri.parse('http://localhost/kingsmart_ci/MenuScreen/remove_shopping_cart_item/?session_id='+ session_id.toString() + '&shopping_cart_product_id=' + shopping_cart_product_id.toString() );
    Response response = await get(uri);
    int statusCode = response.statusCode;
    String responseBody = response.body;
    print ( responseBody );
    if ( statusCode == 200 ) {
      return true;
    }
    return false;
  }

}
