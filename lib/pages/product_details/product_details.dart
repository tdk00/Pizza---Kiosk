import 'package:flutter/material.dart';
import 'package:flutter_app_desktop/pages/Menu_products/menu_products.dart';
import 'package:flutter_app_desktop/pages/product_details/api/product_details_api.dart';
import 'package:flutter_app_desktop/pages/product_details/ingredient_counter.dart';

import '../../helper/translate_helper.dart';
import '../../models/models.dart';

class ProductDetails extends StatefulWidget {
  String id;
  int count;
  ProductDetails(this.id, this.count);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  var _ingredientsList = [];

  var _extrasFuture = ProductDetailsApi.getExtrasBySizeId(0);
  var _productDetailsFuture = ProductDetailsApi.getProductDetailsById(0);
  int _itemCount = 2;
  double _itemPrice = 3.90;
  var sizesData = [];
  var _showSizesDropdown = false;
  ProductSize _dropdownValue = ProductSize(0, "Standart", "barkod", 0);
  var _firstLoad = true;
  var _firstLoadIngredients = true;
  Future<void> setDetails() async {
    List details = await ProductDetailsApi.getProductDetailsById( widget.id );
    if (details.isNotEmpty) {
      if( details[0].sizes.length > 0 )
        {
          _showSizesDropdown = true;
        }
      setState(() {
        _extrasFuture = ProductDetailsApi.getExtrasBySizeId( details[0].sizes[0].id );
        _dropdownValue = details[0].sizes[0];
        _itemPrice = details[0].sizes[0].price;
        _itemCount = widget.count;
      });

    }
  }

  void initState() {
    super.initState();
    setState(() {
      setDetails();
      _productDetailsFuture = ProductDetailsApi.getProductDetailsById(widget.id);
    });
  }



  void _update(double ingredientPrice, int ingredientCount, int ingredientId, increasePrice ) {
    if( increasePrice )
      {
        setState(() => _itemPrice += ingredientPrice);
      }
    for( var i = 0; i < _ingredientsList.length; i++ )
      {
        if( _ingredientsList[i].id == ingredientId )
          {
              _ingredientsList[i].count = ingredientCount;
          }
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
            future: _productDetailsFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                if ( _firstLoad )
                {
                  _dropdownValue = snapshot.data[0].sizes[0];
                }
                return Row(children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 29,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width / 11.8),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xFFBABABA))),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.width / 7.8,
                                    width:
                                        MediaQuery.of(context).size.width / 7.8,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(snapshot.data[0].img),
                                        fit: BoxFit.fitWidth,
                                        scale: 0.8,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 414,
                                            child: Text(
                                              snapshot.data[0].name,
                                              style: TextStyle(
                                                  fontSize: snapshot.data[0].name.length > 45 ?
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          70 : MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      60,
                                                  fontWeight: FontWeight.w800),
                                            )),
                                        Expanded(
                                          flex: _itemCount > 9 ? 118 : 108,
                                          child: Container(
                                            height: 30,
                                            margin: EdgeInsets.only(
                                                left: 3, right: 3),
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
                                                          onPressed: () =>
                                                              setState(() =>
                                                                  _itemCount--),
                                                        )
                                                      : IconButton(
                                                          icon: Icon(
                                                              Icons.remove,
                                                              size: 10),
                                                          onPressed: () =>
                                                              null),
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
                                                    icon: new Icon(Icons.add,
                                                        size: 10),
                                                    onPressed: () => setState(
                                                        () => _itemCount++),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      (_itemCount * _itemPrice)
                                              .toStringAsFixed(2) +
                                          " AZN",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              74,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  _showSizesDropdown ? Container(
                                    margin: EdgeInsets.only(top: 20),
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 114, right: MediaQuery.of(context).size.width / 114),
                                    width: MediaQuery.of(context).size.width / 4,
                                    height: MediaQuery.of(context).size.height / 28,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F4F5)
                                    ),
                                    child: DropdownButton(
                                      value: _dropdownValue,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      isExpanded: true,
                                      iconSize: 22,
                                      elevation: 16,
                                      underline: SizedBox(),
                                      style: const TextStyle(
                                          color: Color(0xFF6F6F6F)),
                                      onChanged: (ProductSize? newValue) {
                                        setState(() {
                                          _dropdownValue = newValue!;
                                          _firstLoad = false;
                                          _itemPrice = _dropdownValue.price;
                                          _extrasFuture =
                                              ProductDetailsApi.getExtrasBySizeId(
                                                  _dropdownValue.id);
                                        });
                                      },
                                      items: snapshot.data[0].sizes
                                          .map<DropdownMenuItem<ProductSize>>(
                                              (item) {
                                        return DropdownMenuItem<ProductSize>(
                                          child: Text(item.name, style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.width / 114,
                                          ),),
                                          value: item,
                                        );
                                      }).toList(),
                                    ),
                                  ) :
                                      Container(),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 30,
                            child: FutureBuilder(
                                future: _extrasFuture,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data!.isNotEmpty) {
                                    return Column(children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6.2,
                                            top: 20,
                                            bottom: 40),
                                        child: Align(
                                          child: TranslatedText(TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  48), 'extras', 'Ekstralar'),
                                          /*Text(
                                            "Ekstralar",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    48),
                                          ),*/
                                          alignment: Alignment.topLeft,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  14.8,
                                              bottom: 50),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: snapshot.data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                if( _firstLoadIngredients )
                                                  {
                                                    _ingredientsList.add(
                                                        IngredientDetails( snapshot.data[index].id, snapshot.data[index].extra_count )
                                                    );
                                                    if( snapshot.data.length - 1 == index )
                                                      {
                                                        _firstLoadIngredients = false;
                                                      }
                                                  }
                                                return IngredientItem(
                                                    snapshot.data[index].id,
                                                    snapshot.data[index].name,
                                                    snapshot.data[index].image,
                                                    snapshot.data[index].price,
                                                    snapshot.data[index].extra_count,
                                                    snapshot.data[index].extra_count,
                                                    _update);
                                              }),
                                        ),
                                      ),

                                    ]);

                                  } else {
                                    return Container();
                                  }
                                }),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width / 11.8),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: ElevatedButton(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 13, bottom: 13),
                                          child: TranslatedText(TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  137,
                                              color: Colors.black),
                                          'back',
                                          'Geriyə'),
                                          /*Text(
                                            "Geriyə",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
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
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                                          MenuProducts()),
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
                                          padding: EdgeInsets.only(
                                              top: 13, bottom: 13),
                                          child: TranslatedText(TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  137,
                                              color: Colors.white),
                                          'addtocart',
                                          'Səbətə Əlavə et'),
                                          /*Text(
                                            "Səbətə Əlavə et",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
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
                                              borderRadius:
                                                  BorderRadius.circular(
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

                                        await ProductDetailsApi.addProductToShoppingCart( _dropdownValue.id , _itemCount,  _ingredientsList  );
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          MenuProducts()
                                                  ),
                                                  (route) => false);
                                            }),
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
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/product_page_ills.png"),
                            fit: BoxFit.none,
                            scale: 1.5,
                          ),
                        ),
                      ))
                ]);
              } else {
                return Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4 ,
                    height: MediaQuery.of(context).size.height / 2,
                    child: CircularProgressIndicator()
                  ),
                );
              }
            }),
      ),
    );
  }
}

class IngredientDetails {

  int id;
  int count;

  IngredientDetails(this.id, this.count);

  IngredientDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        count = json['count'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count': count,
    };
  }

}
