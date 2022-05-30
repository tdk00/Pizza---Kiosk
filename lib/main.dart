import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app_desktop/pages/language_selection/language_selection.dart';


void main() {
  runApp( MyApp(),);
}

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  Timer timer = Timer(Duration(hours: 20), () => {
    // print('aaa')
  });
  void timeOutCallBack() {
    navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyApp()),
            (Route<dynamic> route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
         if (timer != null)
         {
           timer.cancel();
         }
        timer = Timer(Duration(seconds: 8230), () => timeOutCallBack());
      },
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: GestureDetector(
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image:AssetImage("assets/images/touchToStart.jpg"),
                        fit:BoxFit.cover
                    ),
                )
            ),
            onTap:() async {


          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => const LanguageSelectionWidget()), (route) => false);
        }
        )
    );
  }
}
