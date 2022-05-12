import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_desktop/helper/translation_api.dart';

class TranslatedText extends StatefulWidget {

  TextStyle textstyle;
  String wordKey, defaultWord;

  TranslatedText(this.textstyle, this.wordKey, this.defaultWord, {Key? key}) : super(key: key);

  @override
  _TranslatedTextState createState() => _TranslatedTextState();
}

class _TranslatedTextState extends State<TranslatedText> {
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: TranslationApi.getTranslation(widget.wordKey),
    builder:
    (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData && snapshot.data!.isNotEmpty)
    {
      return Text(snapshot.data.toString().replaceAll('"', ''), style: widget.textstyle);
    }
    else
      {
      return Text(widget.defaultWord, style: widget.textstyle);
      }
    }
    );
  }
}