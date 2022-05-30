import 'dart:convert';
import 'package:flutter_app_desktop/helper/language_helper.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helper/config_helper.dart';
import '../../../models/models.dart';

class ProductDetailsApi {


  static getProductDetailsById( id ) async {
    var lang = await LanguageHelper.getLang();
    var base_url = await ConfigHelper.baseUrl();
    final uri =Uri.parse(base_url + 'ProductDetailsScreen/product_details_by_id/?product_id='+ id.toString() +'&lang=' + lang);

    Response response = await get(uri);
    int statusCode = response.statusCode;
    String responseBody = response.body;


    List<Product> productsList = [];

    if ( statusCode == 200 ) {
      for (final product in jsonDecode(responseBody)) {

        List<ProductSize> sizes = [];

        for ( final size in  product['sizes']  ) {
              sizes.add(
                ProductSize( int.parse( size['id'] ), size['size_name'], size['barkod'], double.parse( size['price'] ) )
              );
        }


        productsList.add(
            Product( int.parse( product['id'] ), int.parse( product['category_id'] ), product['name'], product['image'], sizes )
        );

      }
    }

    return productsList;
  }

  static getSizeData( id ) async {
    var lang = await LanguageHelper.getLang();
    var base_url = await ConfigHelper.baseUrl();
    final uri =Uri.parse(base_url + 'ProductDetailsScreen/product_details_by_id/?product_id='+ id.toString() +'&lang=' + lang);

    Response response = await get(uri);
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var resBody = json.decode(responseBody);

    return resBody;
  }


  static getExtrasBySizeId( id ) async {
    var lang = await LanguageHelper.getLang();
    var base_url = await ConfigHelper.baseUrl();
    final uri =Uri.parse(base_url + 'ProductDetailsScreen/get_extras_by_product_id/?size_id='+ id.toString() +'&lang=' + lang);

    Response response = await get(uri);
    int statusCode = response.statusCode;
    String responseBody = response.body;


    List<Extra> extrasList = [];

    if ( statusCode == 200 ) {
      for (final extra in jsonDecode(responseBody)) {
        extrasList.add(
            Extra(
              int.parse( extra['extra_id'] ),
              0,
              int.parse( extra['size_id'] ),
              int.parse( extra['extra_count'] ),
              int.parse( extra['extra_count'] ),
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

  static addProductToShoppingCart ( size_id, count, Extralist ) async {
    final prefs = await SharedPreferences.getInstance();
    var session_id = prefs.getString('session_id') ;

    var base_url = await ConfigHelper.baseUrl();
    final uri =Uri.parse(base_url + 'ProductDetailsScreen/add_product_to_shopping_cart');
    var body = json.encode({ "size_id": size_id, "count" : count, "extras" : jsonEncode(Extralist), "session_id" : session_id });
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

  static updateShoppingCartProduct ( shoppingCartProductId, count, Extralist ) async {
    final prefs = await SharedPreferences.getInstance();
    var session_id = prefs.getString('session_id') ;
    var base_url = await ConfigHelper.baseUrl();
    final uri =Uri.parse(base_url + 'ProductDetailsScreen/update_shopping_cart_product');
    var body = json.encode({ "shopping_cart_product_id": shoppingCartProductId, "count" : count, "extras" : jsonEncode(Extralist), "session_id" : session_id });
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
