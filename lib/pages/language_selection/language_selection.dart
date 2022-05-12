import 'package:flutter/material.dart';
import 'package:flutter_app_desktop/pages/eating_place/eating_place.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectionWidget extends StatelessWidget {
  const LanguageSelectionWidget({Key? key}) : super(key: key);
  void setLang (String lang) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', lang);
    prefs.setString( 'session_id', DateTime.now().millisecondsSinceEpoch.toString() );

  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.2 ),
                child: Column(
                  children: <Widget>[
                    Text('Zəhmət olmasa,',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontSize: MediaQuery.of(context).size.width / 22.3)),
                    Align(
                      alignment: Alignment.center,
                      child: Text('dili seçin',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery.of(context).size.width / 22.3),
                          textAlign: TextAlign.center),
                    ),
                  ],
                )),
            SizedBox( height: MediaQuery.of(context).size.height / 10.8 ),
            Container(
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      child: Text(
                          "Azərbaycan",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 48, fontWeight: FontWeight.normal ),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 25,
                              top: MediaQuery.of(context).size.height / 37.4,
                              right: MediaQuery.of(context).size.width / 25,
                              bottom: MediaQuery.of(context).size.height / 37.4)),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFEA262E)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(7)),
                                  side: BorderSide(color: Colors.red)
                              )
                          )
                      ),
                      onPressed: () {
                        setLang('az');
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (_) => const EatingPlaceWidget()), (route) => false);
                          }),
                  SizedBox(width: MediaQuery.of(context).size.width / 27.87),
                  ElevatedButton(
                      child: Text(
                          "English",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 48, fontWeight: FontWeight.normal )
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 25,
                              top: MediaQuery.of(context).size.height / 37.4,
                              right: MediaQuery.of(context).size.width / 25,
                              bottom: MediaQuery.of(context).size.height / 37.4)),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFEA262E)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(7)),
                                  side: BorderSide(color: Colors.red)
                              )
                          )
                      ),
                      onPressed: () {
                          setLang('en');
                          Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (_) => const EatingPlaceWidget()), (route) => false);
                      }
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 27.87),
                  ElevatedButton(
                      child: Text(
                          "Русский",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 48, fontWeight: FontWeight.normal )
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 25,
                              top: MediaQuery.of(context).size.height / 37.4,
                              right: MediaQuery.of(context).size.width / 25,
                              bottom: MediaQuery.of(context).size.height / 37.4)),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFEA262E)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(7)),
                                  side: BorderSide(color: Colors.red)
                              )
                          )
                      ),
                      onPressed: () {
                            setLang('ru');
                            Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (_) => const EatingPlaceWidget()), (route) => false);
                      }
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
