import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/no_order_component.dart';
import 'package:steuermachen/components/tax_year_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/tax/declaration_tax/declaration_tax_view_model.dart';
import 'package:steuermachen/screens/profile/what_in_works/what_in_work_steps_component.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_data_collector_wrapper.dart';

class WhatInWorkYearSelectionScreen extends StatefulWidget {
  const WhatInWorkYearSelectionScreen({Key? key}) : super(key: key);

  @override
  State<WhatInWorkYearSelectionScreen> createState() =>
      _WhatInWorkYearSelectionScreenState();
}

class _WhatInWorkYearSelectionScreenState
    extends State<WhatInWorkYearSelectionScreen> {
  late DeclarationTaxViewModel provider;
  @override
  void initState() {
    provider = Provider.of<DeclarationTaxViewModel>(context, listen: false);
    _fetchTaxFiledYears();
    super.initState();
  }

  void _fetchTaxFiledYears() {
    if (provider.taxFiledYears.status != Status.completed) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => {provider.fetchTaxFiledYears()},
      );
    }
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
        child: Consumer<DeclarationTaxViewModel>(
            builder: (context, consumer, child) {
          if (consumer.taxFiledYears.status == Status.loading) {
            return const EmptyScreenLoaderComponent();
          } else if (consumer.taxFiledYears.status == Status.error) {
            return ErrorComponent(
              message: consumer.taxFiledYears.message!,
              onTap: () async {
                await consumer.fetchTaxFiledYears();
              },
            );
          } else {
            if (consumer.taxFiledYears.data == null) {
              return const NoOrderComponent();
            }
            return _getMainBody(consumer.taxFiledYears.data);
          }
        }),
      ),
    );
  }

  _getMainBody(var submittedTaxYears) {
    List<SafeAndDeclarationTaxDataCollectorWrapper> data =
        List<SafeAndDeclarationTaxDataCollectorWrapper>.from(
      submittedTaxYears.map(
        (e) =>
            SafeAndDeclarationTaxDataCollectorWrapper.fromJson(e.data(), e.id),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: RefreshIndicator(
        onRefresh: () => provider.fetchTaxFiledYears(),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            data.sort(((a, b) => a.taxYear!.compareTo(b.taxYear!)));
            if (data[index].taxYear != DateTime.now().year.toString()) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TaxYearComponent(
                  year: data[index].taxYear!,
                  onTap: () {
                    Utils.customDialog(
                      context,
                      WhatInWorkStepsComponent(
                        submittedTaxYears: data[index],
                      ),
                    );
                  },
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
