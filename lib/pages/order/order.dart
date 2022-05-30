import 'dart:async';

import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_desktop/helper/printer_helper.dart';
import 'package:flutter_app_desktop/helper/translate_helper.dart';
import 'package:flutter_app_desktop/pages/basket/order/order_item.dart';
import 'package:flutter_app_desktop/pages/menu_products/api/shopping_cart_api.dart';
import 'package:flutter_app_desktop/pages/menu_products/menu_products.dart';
import 'package:flutter_app_desktop/pages/order/order_success.dart';
import 'package:flutter_app_desktop/pages/payment_method_selection/payment_method_selection.dart';

import '../../main.dart';
import '../../models/models.dart';
import '../Menu_products/api/menu_products_api.dart';
import '../eating_place/order_api.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => new _OrderState();
}

class _OrderState extends State<Order> {
  var _productsList = [];
  double _total = 0.0; //totali apiden getirmek, widgetin icinde setState etmek olmur
  var _orderFuture = ShoppingCartApi.getShoppingCartProducts(); // TODO: bunun modeli deyishib, duzeltmek
  var firstLoad = true;
  var _firstLoadOrder = true;
  void _update_shopping_cart( Future<List<ShoppingCartProduct>> link ) {
    setState( () {
      _orderFuture = ShoppingCartApi.getShoppingCartProducts();
    } );
  }
  void _updateTotal(double productSum) {
    setState(() => _total += productSum );
  }

  void _updateProductCountArray(int shoppingCartProductId, int shoppingCartProductCount ) {
    for( var i = 0; i < _productsList.length; i++ )
    {
      if( _productsList[i].id == shoppingCartProductId )
      {
        _productsList[i].count = shoppingCartProductCount;
      }
    }

  }

  void _sendCountsToApi() {
    MenuProductsApi.updateShoppingCartProductCounts( _productsList );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 11.8),
              child: Column(
                children: [
                     Container(
                       margin: EdgeInsets.only(top: 50, bottom: 50),
                      child: TranslatedText(
                        TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 53.3,
                            fontWeight: FontWeight.w500
                        ),
                        'myorder',
                        'Mənim sifarişim'
                      )
                       /*Text("Mənim sifarişim", style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 53.3,
                        fontWeight: FontWeight.w500
                      ),),*/
                  ),
                   FutureBuilder(
                      future: _orderFuture,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          if( firstLoad )
                            {
                              _total = snapshot.data[0].total;
                              firstLoad = false;
                            }
                          return Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      if( _firstLoadOrder )
                                      {
                                        _productsList.add(
                                            ShoppingCartProductDetails( snapshot.data[index].shopping_cart_product_id, snapshot.data[index].product_count )
                                        );
                                        if( snapshot.data.length - 1 == index )
                                        {
                                          _firstLoadOrder = false;
                                        }
                                      }
                                      return OrderItem(
                                          snapshot.data[index].shopping_cart_product_id,
                                          snapshot.data[index].name,
                                          snapshot.data[index].image,
                                          snapshot.data[index].price_including_extras,
                                          snapshot.data[index].product_count,
                                          _updateTotal,
                                          _update_shopping_cart,
                                          _updateProductCountArray,
                                          _sendCountsToApi);
                                    }),
                                ),
                              Container(
                                margin: EdgeInsets.only(top: 30, bottom: 70),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          'Yekun ' + _total.toStringAsFixed(2), // tercume
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: MediaQuery.of(context) .size .width /68),
                                          textAlign: TextAlign.center),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 10,
                                          child: ElevatedButton(
                                              child: Container(

                                                padding: EdgeInsets.only(top: 13, bottom: 13),
                                                child: TranslatedText(
                                                  TextStyle(
                                                      fontSize:
                                                      MediaQuery.of(context).size.width /
                                                          137,
                                                      color: Colors.black),
                                                  'back',
                                                  'Geriyə'
                                                ),
                                                /*Text(
                                                  "Geriyə",
                                                  style: TextStyle(
                                                      fontSize:
                                                      MediaQuery.of(context).size.width /
                                                          137,
                                                      color: Colors.black),
                                                ),*/
                                              ),
                                              style: ButtonStyle(
                                                padding:
                                                MaterialStateProperty.all<EdgeInsets>(
                                                    EdgeInsets.zero),
                                                shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        MediaQuery.of(context).size.width /
                                                            220),
                                                  ),
                                                ),
                                                backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                  Color(0xFFE3E3E3),
                                                ),
                                              ),
                                              onPressed: () => {
                                                Navigator.pushAndRemoveUntil(context,
                                                    MaterialPageRoute(builder: (_) => MenuProducts()), (route) => false)
                                              }),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(
                                            width: 5,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: ElevatedButton(
                                              child: Container(
                                                padding: EdgeInsets.only(top: 13, bottom: 13),
                                                child: TranslatedText(
                                                  TextStyle(
                                                      fontSize:
                                                      MediaQuery.of(context).size.width /
                                                          137,
                                                      color: Colors.white),
                                                  'pay',
                                                  'Ödəniş et'
                                                ),
                                                /*Text(
                                                  "Ödəniş et",
                                                  style: TextStyle(
                                                      fontSize:
                                                      MediaQuery.of(context).size.width /
                                                          137,
                                                      color: Colors.white),
                                                ),*/
                                              ),
                                              style: ButtonStyle(
                                                padding:
                                                MaterialStateProperty.all<EdgeInsets>(
                                                    EdgeInsets.zero),
                                                shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        MediaQuery.of(context).size.width /
                                                            220),
                                                  ),
                                                ),
                                                backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                  Color(0xFF37A817),
                                                ),
                                              ),
                                              onPressed: () async {
                                                await MenuProductsApi.updateShoppingCartProductCounts( _productsList );
                                                var returnObj = await OrderApi.addOrder(_total, 'card');
                                                if( returnObj['orderNumber'] > 0  )
                                                  {
                                                    var orderId = returnObj['orderId'].toString();
                                                    var orderNumber = returnObj['orderNumber'].toString();

                                                     const PaperSize paper = PaperSize.mm80;
                                                     final profile = await CapabilityProfile.load();
                                                     final printer = NetworkPrinter(paper, profile);

                                                    final PosPrintResult res = await printer.connect('192.168.100.87', port: 9100);

                                                    if (res == PosPrintResult.success)
                                                    {
                                                      PrinterHelper().generatePrintContent(printer , orderNumber, orderId);
                                                      Timer(Duration(seconds: 2), () =>
                                                      {
                                                        printer.disconnect()
                                                      });
                                                    }
                                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => OrderSuccess(orderNumber, orderId)), (route) => false);
                                                  }

                                              }),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),


                ],
              ),
            ),
          ),
          Expanded(
            flex: 7 ,
            child: Container(
            decoration: BoxDecoration
              (
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/order_ills.png"),
                fit: BoxFit.none,
                scale: 1.5,),
            ),),)
        ],
      ),
    ),
    );
  }
}