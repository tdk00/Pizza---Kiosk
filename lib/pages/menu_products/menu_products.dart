import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_desktop/main.dart';
import 'package:flutter_app_desktop/models/models.dart';
import 'package:flutter_app_desktop/pages/menu_products/api/shopping_cart_api.dart';

import '../../helper/translate_helper.dart';
import '../basket/menu_products/basketItem.dart';
import '../order/order.dart';
import '../product_details/product_details.dart';
import 'api/menu_products_api.dart';

class MenuProducts extends StatefulWidget {
  const MenuProducts({Key? key}) : super(key: key);

  @override
  _MenuProductsState createState() => _MenuProductsState();
}

class _MenuProductsState extends State<MenuProducts> {
  var _productsList = [];
  var _productsFuture = MenuProductsApi.getProducts(1);
  var _basketFuture = ShoppingCartApi.getShoppingCartProducts();
  var _categoryName = "PizzaA";
  var _defaultCat = 0;

  var _firstLoadShoppingCart = true;

  void _update_shopping_cart(Future<List<ShoppingCartProduct>> link) {
    setState(() {
      _basketFuture = ShoppingCartApi.getShoppingCartProducts();
    });
  }

  void _updateProductCountArray(
      int shoppingCartProductId, int shoppingCartProductCount) {
    for (var i = 0; i < _productsList.length; i++) {
      if (_productsList[i].id == shoppingCartProductId) {
        _productsList[i].count = shoppingCartProductCount;
      }
    }
  }

  void _sendCountsToApi() {
    MenuProductsApi.updateShoppingCartProductCounts(_productsList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 24,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 14.5,
                ),
                Container(
                  child: TranslatedText(
                      TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 36.9,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                      "menu",
                      'Menu'), /*Text(
                    'Menu', // tercume
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 36.9,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),*/
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 21.6,
                        left: MediaQuery.of(context).size.width / 32,
                        right: MediaQuery.of(context).size.width / 32.6),
                    child: FutureBuilder(
                        future: MenuProductsApi.getCategories(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            _categoryName = snapshot.data[0].name;
                            return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        mainAxisExtent: 210,
                                        maxCrossAxisExtent: 130,
                                        // childAspectRatio: 0.77,
                                        crossAxisSpacing:
                                            MediaQuery.of(context).size.width /
                                                29,
                                        mainAxisSpacing:
                                            MediaQuery.of(context).size.width /
                                                210),
                                itemCount: snapshot.data.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  bool isActive = index == 0 && _defaultCat == 0
                                      ? true
                                      : _defaultCat > 0 &&
                                              snapshot.data[index].id ==
                                                  _defaultCat
                                          ? true
                                          : false;
                                  return Column(children: [
                                    Expanded(
                                      flex: 770,
                                      child: ElevatedButton(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(110),
                                              ),
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                13.9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                13.9,
                                            padding: EdgeInsets.only(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                        .data[index].icon),
                                                    fit: BoxFit.none,
                                                    scale: 1.5,
                                                    colorFilter: isActive ==
                                                            false
                                                        ? const ColorFilter
                                                                .mode(
                                                            Colors.black,
                                                            BlendMode.srcATop)
                                                        : const ColorFilter
                                                                .mode(
                                                            Colors.white,
                                                            BlendMode.srcATop)),
                                              ),
                                              child:
                                                  null /* add child content here */,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            120),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              isActive
                                                  ? Color(0xFFEA262E)
                                                  : Color(0xFFF2F4F5),
                                            ),
                                          ),
                                          onPressed: () => {
                                                setState(() {
                                                  _categoryName =
                                                      snapshot.data[index].name;
                                                  _productsFuture =
                                                      MenuProductsApi
                                                          .getProducts(snapshot
                                                              .data[index].id);
                                                  _defaultCat =
                                                      snapshot.data[index].id;
                                                })
                                              }),
                                    ),
                                    Expanded(
                                      flex: 408,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            snapshot
                                                .data[index].name, // tercume
                                            style: TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    80),
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ]);
                                });
                          } else {
                            return Container();
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              flex: 52,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 11.5,
                    ),
                    Container(
                      child: Text(
                        _categoryName.toString(), // tercume
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 48,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 21.6,
                            left: MediaQuery.of(context).size.width / 32,
                            right: MediaQuery.of(context).size.width / 32.6),
                        child: FutureBuilder(
                            future: _productsFuture,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                return GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 130,
                                            childAspectRatio: 0.67,
                                            crossAxisSpacing:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    83.4,
                                            mainAxisSpacing:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    59),
                                    itemCount: snapshot.data.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(children: [
                                        Expanded(
                                          flex: 670,
                                          child: ElevatedButton(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(50)),
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    13.9,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    13.9,
                                                padding: EdgeInsets.only(),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot
                                                              .data[index].img),
                                                      fit: BoxFit.fitWidth,
                                                      scale: 1.8,
                                                    ),
                                                  ),
                                                  child:
                                                      null /* add child content here */,
                                                ),
                                              ),
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                120),
                                                  )),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color(0xFFFFFFFF))),
                                              onPressed: () async {
                                                await MenuProductsApi
                                                    .updateShoppingCartProductCounts(
                                                        _productsList);
                                                setState(() {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              ProductDetails(
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  1)),
                                                      (route) => false);
                                                });
                                              }),
                                        ),
                                        Expanded(flex: 56, child: SizedBox()),
                                        Expanded(
                                          flex: 369,
                                          child: Text(
                                              snapshot
                                                  .data[index].name, // tercume
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          120),
                                              textAlign: TextAlign.center),
                                        ),
                                      ]);
                                    });
                              } else {
                                return Container();
                              }
                            }),
                      ),
                    )
                  ],
                ),
                color: Color(0xFFF2F4F5),
              )),
          Expanded(
              flex: 24,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10.5,
                  ),
                  Container(
                    child: TranslatedText(
                        TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 53.3,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w500),
                        'sebetim',
                        'Alış-veriş səbətim'), /*Text(
                      'Alış-veriş səbətim', // tercume
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 53.3,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500),
                    ),*/
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30.5,
                  ),
                  FutureBuilder(
                      future: _basketFuture,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (_firstLoadShoppingCart) {
                                    _productsList.add(
                                        ShoppingCartProductDetails(
                                            snapshot.data[index]
                                                .shopping_cart_product_id,
                                            snapshot
                                                .data[index].product_count));
                                    if (snapshot.data.length - 1 == index) {
                                      _firstLoadShoppingCart = false;
                                    }
                                  }
                                  return BasketItem(
                                      snapshot
                                          .data[index].shopping_cart_product_id,
                                      snapshot.data[index].name,
                                      snapshot.data[index].size_name,
                                      snapshot.data[index].image,
                                      snapshot
                                          .data[index].price_including_extras,
                                      snapshot.data[index].product_count,
                                      _update_shopping_cart,
                                      _updateProductCountArray,
                                      _sendCountsToApi);
                                }),
                          );
                        } else {
                          return Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 40,
                                right: MediaQuery.of(context).size.width / 40),
                            height: MediaQuery.of(context).size.height / 1.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/empty_cart_ills.png"),
                                fit: BoxFit.fitWidth,
                                scale: 1.9,
                              ),
                            ),
                          );
                        }
                      }),
                  FutureBuilder(
                      future: _basketFuture,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return Container(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 50,
                              top: MediaQuery.of(context).size.height / 50,
                              left: MediaQuery.of(context).size.width / 60.5,
                              right: MediaQuery.of(context).size.width / 60.5,
                            ),
                            decoration: BoxDecoration(color: Colors.white),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: ElevatedButton(
                                      child: Container(
                                        child: TranslatedText(
                                            TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    137,
                                                color: Colors.black),
                                            "cancel",
                                            "Ləğv et"), /*Text(
                                    "Ləğv et",
                                    style: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.width /
                                            137,
                                        color: Colors.black),
                                  ),*/
                                      ),
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(EdgeInsets.zero),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    220),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Color(0xFFE3E3E3),
                                        ),
                                      ),
                                      onPressed: () => {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        MyHomePage()),
                                                (route) => false)
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
                                        child: TranslatedText(
                                            TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    137,
                                                color: Colors.white),
                                            'tamamla',
                                            'tamamla'),
                                        /*Text(
                                    "Tamamla",
                                    style: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.width /
                                            137,
                                        color: Colors.white),
                                  ),*/
                                      ),
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(EdgeInsets.zero),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    220),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Color(0xFF37A817),
                                        ),
                                      ),
                                      onPressed: () async {
                                        await MenuProductsApi
                                            .updateShoppingCartProductCounts(
                                                _productsList);
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => Order()),
                                            (route) => false);
                                      }),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ],
              )),
        ],
      ),
    ));
  }
}

class ShoppingCartProductDetails {
  int id;
  int count;

  ShoppingCartProductDetails(this.id, this.count);

  ShoppingCartProductDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        count = json['count'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count': count,
    };
  }
}
