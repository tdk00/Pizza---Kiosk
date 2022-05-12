import 'package:flutter/material.dart';
import 'package:flutter_app_desktop/helper/translate_helper.dart';
import 'package:flutter_app_desktop/pages/Menu_products/menu_products.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EatingPlaceWidget extends StatelessWidget {
  const EatingPlaceWidget({Key? key}) : super(key: key);

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
                      child: Text('Yemək yeri', // tercume
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize:
                                  MediaQuery.of(context).size.width / 22.3),
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
                                image: AssetImage("assets/images/eatHere.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: null /* add child content here */,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFEA262E))),
                        onPressed: ()
                    async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setInt( 'is_takeaway', 0 );

                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (_) => const MenuProducts()), (route) => false);
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
                            fontSize: MediaQuery.of(context).size.width / 40),
                        'eathere',
                        'Burada yemək',
                      ),
                      /*Text('Burada yemək', // tercume
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery.of(context).size.width / 40),
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
                                image: AssetImage("assets/images/takeAway.png"),
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
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setInt( 'is_takeaway', 1 );
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (_) => const MenuProducts()), (route) => false);
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
                            fontSize: MediaQuery.of(context).size.width / 40),
                        'takeaway',
                        'Özünüzlə aparmaq',
                      ),
                      /*Text('Özünüzlə aparmaq', // tercume
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery.of(context).size.width / 40),
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
