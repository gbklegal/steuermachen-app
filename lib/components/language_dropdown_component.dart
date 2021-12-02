import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/providers/language_provider.dart';

class LanguageDropdownComponent extends StatefulWidget {
  const LanguageDropdownComponent({Key? key}) : super(key: key);

  @override
  _LanguageDropdownComponentState createState() =>
      _LanguageDropdownComponentState();
}

class _LanguageDropdownComponentState extends State<LanguageDropdownComponent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context, consumer, child) {
      return DropdownButton<String>(
        value: consumer.value,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          consumer.changeLanguage(newValue!, context);
        },
        items:
            <String>['en', 'de'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }
}
