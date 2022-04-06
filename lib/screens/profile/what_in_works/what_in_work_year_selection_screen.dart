import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/app_bar/appbar_component.dart';
import '../../../constants/assets/asset_constants.dart';
import '../../../constants/strings/string_constants.dart';
import '../../../providers/tax/declaration_tax/declaration_tax_provider.dart';
import '../../../wrappers/common_response_wrapper.dart';

class WhatInWorkYearSelectionScreen extends StatefulWidget {
  const WhatInWorkYearSelectionScreen({Key? key}) : super(key: key);

  @override
  State<WhatInWorkYearSelectionScreen> createState() =>
      _WhatInWorkYearSelectionScreenState();
}

class _WhatInWorkYearSelectionScreenState
    extends State<WhatInWorkYearSelectionScreen> {
  late DeclarationTaxProvider provider;
  CommonResponseWrapper? res;
  @override
  void initState() {
    provider = Provider.of<DeclarationTaxProvider>(context, listen: false);
    provider.checkTaxIsAlreadySubmit().then((value) {
      setState(() {
        res = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: true,
        showPersonIcon: false,
        showBottomLine: true,
      ),
      body: Column(),
    );
  }
}
