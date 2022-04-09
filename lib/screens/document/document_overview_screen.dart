import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/tax_year_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/document/document_view_model.dart';
import 'package:steuermachen/wrappers/document/document_option_wrapper.dart';

class DocumentOverviewScreen extends StatefulWidget {
  const DocumentOverviewScreen(
      {Key? key,
      this.showNextBtn = false,
      this.onNextBtnRoute,
      this.uploadBtnNow = false,
      this.showRoundBody = true})
      : super(key: key);

  final bool? showNextBtn;
  final bool? uploadBtnNow;
  final String? onNextBtnRoute;
  final bool? showRoundBody;
  @override
  State<DocumentOverviewScreen> createState() => _DocumentOverviewScreenState();
}

class _DocumentOverviewScreenState extends State<DocumentOverviewScreen> {
  late String selectImageList;
  late String selectPDF;
  User? user = FirebaseAuth.instance.currentUser;
  late DocumentsViewModel _provider;
  int year = DateTime.now().year;
  List<int> years = [];
  @override
  void initState() {
    super.initState();
    _getYearList();
    _provider = Provider.of<DocumentsViewModel>(context, listen: false);
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _provider.fetchDocumentOptionsData());
  }

  _getYearList() {
    for (var i = 4; i >= 0; i--) {
      int tempYear = year - i;
      years.add(tempYear);
    }
    return years;
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
      body: Consumer<DocumentsViewModel>(
        builder: (context, consumer, child) {
          return _mainBody();
        },
      ),
    );
  }

  SingleChildScrollView _mainBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            TextComponent(
              LocaleKeys.documentOverview,
              style: FontStyles.fontMedium(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            for (var i = 0; i < years.length; i++)
              TaxYearComponent(
                year: years[i].toString(),
                onTap: () {
                  Navigator.pushNamed(
                      context, RouteConstants.documentOverviewDetailScreen);
                },
              )
          ],
        ),
      ),
    );
  }
}
