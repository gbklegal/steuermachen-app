import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/screens/profile/what_in_works/what_in_work_screen.dart';
import 'package:steuermachen/utils/utils.dart';
import '../../../components/selection_card_component.dart';
import '../../../constants/assets/asset_constants.dart';
import '../../../constants/colors/color_constants.dart';
import '../../../constants/styles/font_styles_constants.dart';
import '../../../languages/locale_keys.g.dart';
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
    super.initState();
  }

  final pageController = PageController(initialPage: 0);
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: ColorConstants.black,
          ),
        ),
        title: Transform.translate(
          offset: const Offset(-13, -2),
          child: TextComponent(
            LocaleKeys.checkWhatInWorks,
            style: FontStyles.fontMedium(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<CommonResponseWrapper?>(
          future: provider.checkTaxIsAlreadySubmit(),
          builder: (context, snapshot) {
            if (!snapshot.hasError && snapshot.hasData) {
              List<QueryDocumentSnapshot<Map<String, dynamic>>>?
                  submittedTaxYears = snapshot.data?.data;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ListView.builder(
                  itemCount: submittedTaxYears?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SelectionCardComponent(
                        title: submittedTaxYears?[index]["tax_year"],
                        onTap: () {
                          Utils.customDialog(
                            context,
                            WhatInWorkStepsComponent(
                              submittedTaxYears: submittedTaxYears?[index],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: TextComponent(ErrorMessagesConstants.somethingWentWrong),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Image.asset(
                      AssetConstants.tax,
                      height: 120,
                    ),
                  ),
                  const TextComponent("You haven't submitted any tax"),
                ],
              );
            } else {
              return const LoadingComponent();
            }
          },
        ),
      ),
    );
  }
}
