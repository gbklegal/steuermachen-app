import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

class SelectDocumentForScreen extends StatelessWidget {
  const SelectDocumentForScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
      ),
    );
  }
}
