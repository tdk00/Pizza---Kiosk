import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_desktop/main.dart';

import '../../helper/translate_helper.dart';

class OrderSuccess extends StatelessWidget {
  final String orderNumber;
  final String orderId;
  const OrderSuccess(this.orderNumber, this.orderId, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () =>
    {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MyHomePage()), (route) => false)
    });
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 2.9,),
            SizedBox( child: TranslatedText(
                TextStyle(
                fontSize: 72, color: Colors.green, fontWeight: FontWeight.bold
            ), "thankyou", "Təşəkkür edirik" )),
            SizedBox( child: TranslatedText(TextStyle(
                fontSize: 72
            ), "ordersuccess" , "sifarişiniz uğurla yerinə yetirildi", ))
          ],
        ),
      ),
    );
  }
}
