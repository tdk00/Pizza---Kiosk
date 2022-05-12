

import 'package:flutter/material.dart';
import 'package:flutter_app_desktop/helper/translate_helper.dart';

import '../../../models/models.dart';
import '../../menu_products/api/shopping_cart_api.dart';
import '../../product_details/product_details.dart';
import '../../product_details/product_details_edit.dart';

class OrderItem extends StatefulWidget {
  String name, img;
  int shopping_cart_product_id, count;
  double price;
  final ValueChanged<double> update;
  final ValueChanged<Future<List<ShoppingCartProduct>>> update_shopping_cart;
  final updateProductCountArray;
  final sendCountsToApi;
  OrderItem(
      this.shopping_cart_product_id,
      this.name,
      this.img,
      this.price,
      this.count,
      this.update,
      this.update_shopping_cart,
      this.updateProductCountArray,
      this.sendCountsToApi);
  @override
  _OrderItemState createState() => new _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  int _itemCount = 0;
  double _itemPrice = 0.0;
  void initState() {
    super.initState();
    _itemCount = widget.count;
    _itemPrice = widget.price;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      padding: EdgeInsets.only(bottom: 20, left: MediaQuery.of(context).size.width / 43.6, right: MediaQuery.of(context).size.width / 43.6),
      margin: EdgeInsets.only(
        bottom: 20,
          left: MediaQuery.of(context).size.width / 150,
          right: MediaQuery.of(context).size.width / 110),
      decoration: BoxDecoration(
        color: Color(0xFFFFF6E5),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 148,
            child: Container(
              margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 120),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.img),
                  fit: BoxFit.fitWidth,
                  scale: 2.7,
                ),
              ),
              child: null /* add child content here */,
            ),
          ),
          Expanded(
            flex: 402,
            child: Container(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 120,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ))),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        (_itemPrice * _itemCount).toStringAsFixed(2) + " AZN",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 120,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: ElevatedButton(
                                child: Container(
                                  child: TranslatedText(
                                    TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.width /
                                            137,
                                        color: Colors.black),
                                    'edit',
                                    'dəyişdir'
                                  ),/*Text(
                                    "dəyişdir",
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
                                    Color(0xFFFFDFA6),
                                  ),
                                ),
                                onPressed: () async {
                                  await widget.sendCountsToApi();
                                  setState(() {
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (_) => ProductDetailsEdit( widget.shopping_cart_product_id, _itemCount ) ), (route) => false);
                                  });
                                }
                                ),
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
                                        fontSize:
                                        MediaQuery.of(context).size.width /
                                            137,
                                        color: Colors.black),
                                  'delete',
                                  'sil'
                                  ),
                                  /*Text(
                                    "sil",
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
                                    Color(0xFFFFCCCC),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                      builder: (ctxt) {
                                        return AlertDialog(
                                            content: Container(
                                              height: 120,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 20,),
                                                  TranslatedText(TextStyle(), 'sureremove', 'Məhsul silinsin ?'),
                                                  // Text("Məhsul silinsin ? "),
                                                  SizedBox(height: 20,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      ElevatedButton(
                                                        child: TranslatedText(TextStyle(), 'no', 'Xeyr'),
                                                        //Text("Xeyr"),
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
                                                            Colors.grey,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                      ElevatedButton(
                                                        child: TranslatedText(TextStyle(), 'yes', 'Bəli'),
                                                        //Text("Bəli"),
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
                                                            Colors.red,
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          await ShoppingCartApi.removeShoppingCartItem( widget.shopping_cart_product_id );
                                                          setState(() {
                                                            widget.update_shopping_cart( ShoppingCartApi.getShoppingCartProducts() );
                                                          } );
                                                          Navigator.pop(context);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ));
                                      },
                                      context: context);
                                },
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 60,
            child: TranslatedText(TextStyle(), 'count', 'say'),
            // Text("say"),
          ),
          Expanded(
            flex: _itemCount > 9 ? 198 : 178,
            child: Container(
              height: 30,
              margin: EdgeInsets.only(left: 3, right: 3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFC6C6C6),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: _itemCount > 1
                        ? IconButton(
                      icon: Icon(
                        Icons.remove,
                        size: 10,
                      ),
                      onPressed: () { setState( ()
                        {
                          _itemCount--; widget.update(0 - _itemPrice);
                          widget.updateProductCountArray( widget.shopping_cart_product_id, _itemCount );
                        }
                      );
                      }
                      ,
                    )
                        : IconButton(
                        icon: Icon(Icons.remove, size: 10),
                        onPressed: () => null),
                  ),
                  Expanded(
                    flex: _itemCount > 9 ? 11 : 2,
                    child: Text(
                      _itemCount.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: IconButton(
                      icon: new Icon(Icons.add, size: 10),
                      onPressed: () { setState(() {
                        _itemCount++;
                        widget.update(_itemPrice);
                        widget.updateProductCountArray( widget.shopping_cart_product_id, _itemCount );
                      });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}