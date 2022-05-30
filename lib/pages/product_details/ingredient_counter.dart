

import 'package:flutter/material.dart';

class IngredientItem extends StatefulWidget {
  String name, img;
  int id, count, default_count;
  double price;
  final update;
  IngredientItem(this.id, this.name, this.img, this.price, this.count, this.default_count, this.update);
  @override
  _IngredientItemState createState() => new _IngredientItemState();
}

class _IngredientItemState extends State<IngredientItem> {

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
      height: MediaQuery.of(context).size.height / 14,
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 150,
          right: MediaQuery.of(context).size.width / 110),
      child: Row(
        children: [
          Expanded(
            flex: 58,
            child: Container(
              margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 150 ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.img),
                  fit: BoxFit.fitWidth,
                  scale: 1,
                ),
              ),
              child: null /* add child content here */,
            ),
          ),
          Expanded(
            flex: 402,
            child: Container(
              padding: EdgeInsets.only(top:   0),
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

                ],
              ),
            ),
          ),
          Expanded(
            flex: _itemCount > 9 ? 138 : 128,
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
                    child: _itemCount > 0
                        ? IconButton(
                      icon: Icon(
                        Icons.remove,
                        size: 10,
                      ),
                      onPressed: () => setState(()  {
                        _itemCount--;
                        if( widget.default_count <= _itemCount )
                        {
                          widget.update(0 - _itemPrice, _itemCount, widget.id, true );
                        }
                        else
                          {
                            widget.update(0 - _itemPrice, _itemCount, widget.id, false );
                          }

                      }),
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
                      onPressed: () => setState(() {
                          _itemCount++;
                          if( widget.default_count < _itemCount )
                          {
                            widget.update(_itemPrice, _itemCount, widget.id, true );
                          }
                          else
                          {
                            widget.update(_itemPrice, _itemCount, widget.id, false );
                          }
                      }),
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