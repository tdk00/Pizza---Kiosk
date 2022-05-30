import 'dart:async';
import 'dart:convert';
import 'package:flutter_app_desktop/helper/config_helper.dart';
import 'package:flutter_app_desktop/helper/language_helper.dart';
import 'package:http/http.dart';

import '../../../models/models.dart';

class ShoppingCartProductDetailsApi {


  static getDetailsById( id ) async {
    var lang = await LanguageHelper.getLang();
    final uri = Uri.parse( ConfigHelper.baseUrl() + 'ProductDetailsScreen/shopping_cart_product_details_by_id/?shopping_cart_product_id='+ id.toString() +'&lang=' + lang);

    Response response = await get(uri);
    int statusCode = response.statusCode;
    String responseBody = response.body;


    List<Product> productsList = [];

    if ( statusCode == 200 ) {
      for (final product in jsonDecode(responseBody)) {

        List<ProductSize> sizes = [];
          sizes.add(
              ProductSize( int.parse( product['size_id'] ), product['size_name'], product['barkod'], double.parse( product['price_including_extras'] ) )
          );


        productsList.add(
            Product( int.parse( product['id'] ), int.parse( product['category_id'] ), product['name'], product['image'], sizes )
        );

      }
    }

    return productsList;
  }



  static getExtrasByShoppingCartProductId( id ) async {
    var lang = await LanguageHelper.getLang();
    var base_url = await ConfigHelper.baseUrl();
    final uri =Uri.parse(base_url + 'ProductDetailsScreen/get_extras_by_shopping_cart_product_id/?shopping_cart_product_id='+ id.toString() +'&lang=' + lang);

    Response response = await get(uri);
    int statusCode = response.statusCode;
    String responseBody = response.body;


    List<Extra> extrasList = [];

    if ( statusCode == 200 ) {
      for (final extra in jsonDecode(responseBody)) {
        extrasList.add(
            Extra(
                int.parse( extra['extra_id'] ),
                int.parse( extra['shopping_cart_extra_id'] ),
                int.parse( extra['size_id'] ),
                int.parse( extra['extra_count'] ),
                int.parse( extra['extra_default_count'] != null ? extra['extra_default_count'] : extra['extra_count'] ),
                extra['name'],
                extra['image'],
                extra['barkod'],
                double.parse( extra['price'] )
            )
        );

      }
    }

    return extrasList;
  }


}
