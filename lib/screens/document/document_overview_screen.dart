import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/no_order_component.dart';
import 'package:steuermachen/components/tax_year_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/data/view_models/tax/declaration_tax/declaration_tax_view_model.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/document/document_view_model.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_data_collector_wrapper.dart';

class DocumentOverviewScreen extends StatefulWidget {
  const DocumentOverviewScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DocumentOverviewScreen> createState() => _DocumentOverviewScreenState();
}

class _DocumentOverviewScreenState extends State<DocumentOverviewScreen> {
  late DocumentsViewModel documentViewModel;
  late DeclarationTaxViewModel declarationTaxViewModel;
  @override
  void initState() {
    super.initState();
    documentViewModel = Provider.of<DocumentsViewModel>(context, listen: false);
    declarationTaxViewModel =
        Provider.of<DeclarationTaxViewModel>(context, listen: false);
    _fetchTaxFiledYears();
  }

  void _fetchTaxFiledYears() {
    if (declarationTaxViewModel.taxFiledYears.status != Status.completed ||
        documentViewModel.documentOptions.status != Status.completed) {
      WidgetsBinding.instance?.addPostFrameCallback(
        (_) => {
          documentViewModel.fetchDocumentOptionsData(),
          declarationTaxViewModel.fetchTaxFiledYears(),
        },
      );
    }
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
      body: Consumer<DeclarationTaxViewModel>(
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
          return _mainBody(consumer.taxFiledYears.data);
        }
      }),
    );
  }

  SizedBox _mainBody(var submittedTaxYears) {
    List<SafeAndDeclarationTaxDataCollectorWrapper> data =
        List<SafeAndDeclarationTaxDataCollectorWrapper>.from(
      submittedTaxYears.map(
        (e) =>
            SafeAndDeclarationTaxDataCollectorWrapper.fromJson(e.data(), e.id),
      ),
    );
    return SizedBox(
      height: MediaQuery.of(context).size.height,
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
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => declarationTaxViewModel.fetchTaxFiledYears(),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    data.sort(((a, b) => a.taxYear!.compareTo(b.taxYear!)));
                    return TaxYearComponent(
                      year: data[index].taxYear!,
                      onTap: () {
                        documentViewModel.selectedTax = data[index];
                        Navigator.pushNamed(context,
                            RouteConstants.documentOverviewDetailScreen);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
