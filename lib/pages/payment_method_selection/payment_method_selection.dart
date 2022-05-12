import 'package:flutter/material.dart';
import 'package:flutter_app_desktop/helper/translate_helper.dart';
import 'package:flutter_app_desktop/main.dart';
import 'package:flutter_app_desktop/pages/Menu_products/menu_products.dart';
import 'package:flutter_app_desktop/pages/eating_place/order_api.dart';

class PaymentMethod extends StatelessWidget {
  double totalAmount;

  PaymentMethod(this.totalAmount);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 5.9),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text('Harada ödəmək istəyirsiniz ?', // tercume
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize:
                              MediaQuery.of(context).size.width / 30),
                          textAlign: TextAlign.center),
                    ),
                  ],
                )),
            SizedBox(height: MediaQuery.of(context).size.height / 10.8),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(children: <Widget>[
                    ElevatedButton(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          width: MediaQuery.of(context).size.width / 4.2,
                          height: MediaQuery.of(context).size.width / 5.5,
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 29.5,
                              left: MediaQuery.of(context).size.width / 20.6,
                              right: MediaQuery.of(context).size.width / 20.6,
                              bottom: MediaQuery.of(context).size.width / 29.5),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/payment_method_selection/card_payment.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: null /* add child content here */,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFEA262E))),
                        onPressed: () async {

                          await OrderApi.addOrder(totalAmount, 'card');
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (_) => const MyHomePage()), (route) => false);

                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (_) => const MyHomePage()), (route) => false);
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TranslatedText(
                        TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: MediaQuery.of(context).size.width / 48),
                        'payhere',
                        'Burada Ödəmək'
                      )
                      /*Text('Burada Ödəmək', // tercume
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery.of(context).size.width / 48),
                          textAlign: TextAlign.center),*/
                    ),
                  ]),
                  SizedBox(width: MediaQuery.of(context).size.width / 27.87),
                  Column(children: <Widget>[
                    ElevatedButton(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          width: MediaQuery.of(context).size.width / 4.2,
                          height: MediaQuery.of(context).size.width / 5.5,
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 33.7,
                              left: MediaQuery.of(context).size.width / 14.9,
                              right: MediaQuery.of(context).size.width / 14.9,
                              bottom: MediaQuery.of(context).size.width / 33.7),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/payment_method_selection/pay_here.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: null /* add child content here */,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFEA262E))),
                        onPressed: () async {
                            await OrderApi.addOrder( totalAmount, 'kassa' );
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (_) => const MyHomePage()), (route) => false);


                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TranslatedText(
                        TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: MediaQuery.of(context).size.width / 48),
                        'paycash',
                        'Kassada ödəmək',
                      ),
                      /*Text('Kassada ödəmək', // tercume
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery.of(context).size.width / 48),
                          textAlign: TextAlign.center),*/
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ));
  }
}
