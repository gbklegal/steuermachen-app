import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/no_order_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/web_view_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/process_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/data/view_models/document/document_view_model.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/tax/declaration_tax/declaration_tax_view_model.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/services/networks/dio_client_network.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_data_collector_wrapper.dart';
import 'package:steuermachen/wrappers/tax_steps_wrapper.dart';

class OrderOverviewScreen extends StatefulWidget {
  const OrderOverviewScreen({Key? key}) : super(key: key);

  @override
  State<OrderOverviewScreen> createState() => _OrderOverviewScreenState();
}

class _OrderOverviewScreenState extends State<OrderOverviewScreen> {
  late DeclarationTaxViewModel provider;
  late DocumentsViewModel documentViewModel;
  @override
  void initState() {
    provider = Provider.of<DeclarationTaxViewModel>(context, listen: false);
    documentViewModel = Provider.of<DocumentsViewModel>(context, listen: false);
    _fetchTaxFiledYears();
    super.initState();
  }

  void _fetchTaxFiledYears() {
    if (provider.taxFiledYears.status != Status.completed) {
      WidgetsBinding.instance?.addPostFrameCallback(
        (_) => {
          provider.fetchTaxFiledYears(),
          documentViewModel.fetchDocumentOptionsData()
        },
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
            LocaleKeys.orderOverview,
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
    return RefreshIndicator(
      onRefresh: () => provider.fetchTaxFiledYears(),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          if (data[index].taxYear != DateTime.now().year.toString()) {
            return _OrderCards(data: data[index]);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class _OrderCards extends StatelessWidget {
  const _OrderCards({Key? key, required this.data}) : super(key: key);
  final SafeAndDeclarationTaxDataCollectorWrapper data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: InkWell(
        onTap: () {
          Provider.of<DocumentsViewModel>(context, listen: false).selectedTax =
              data;
          Navigator.pushNamed(
            context,
            RouteConstants.documentOverviewDetailScreen,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.3),
            borderRadius: const BorderRadius.all(
              Radius.circular(2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                _rowTitleAndText(LocaleKeys.product.tr(),
                    getTaxName(data.taxName!) + " " + data.taxYear!),
                _rowTitleAndText(
                    LocaleKeys.price.tr(),
                    data.taxPrice != null
                        ? data.taxPrice! + " Euro (inkl. MwSt.)"
                        : "--"),
                _rowTitleAndText(LocaleKeys.orderDate.tr(),
                    Utils.dateFormatter(data.createdAt.toString())),
                const Divider(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      TextComponent(
                        "${LocaleKeys.status.tr()}: ",
                        style: FontStyles.fontMedium(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, left: 10),
                          child: LinearPercentIndicator(
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2000,
                            percent: calculatePercent(data.steps!),
                            center: TextComponent(
                              "${(calculatePercent(data.steps!) * 100).toStringAsFixed(0)}%",
                              style: FontStyles.fontRegular(
                                  color: ColorConstants.white),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: ColorConstants.toxicGreen,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                data.invoices != null
                    ? ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          AssetConstants.icPdf,
                          height: 18,
                        ),
                        horizontalTitleGap: 0,
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextComponent(
                            "${LocaleKeys.invoice.tr()} #${data.checkOutReference!}",
                            style: FontStyles.fontMedium(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewComponent(
                                      url: data.invoices![0],
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.visibility_sharp,
                                color: ColorConstants.black,
                              ),
                            ),
                            const SizedBox(width: 5),
                            // InkWell(
                            //   onTap: () async {
                            //     String savePath = await getFilePath(Random(10).nextInt(20));
                            //     serviceLocatorInstance<DioClientNetwork>()
                            //         .dio
                            //         .download(data.invoices![0], savePath,
                            //             onReceiveProgress: (received, total) {
                            //       if (total != -1) {
                            //         print((received / total * 100)
                            //                 .toStringAsFixed(0) +
                            //             "%");
                            //       }
                            //     });
                            //   },
                            //   child: const Icon(
                            //     Icons.download,
                            //     color: ColorConstants.black,
                            //   ),
                            // )
                          ],
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  final snackBar = const SnackBar(
    content: TextComponent(LocaleKeys.downloadCompleted),
  );
  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName';

    return path;
  }

  String getTaxName(String taxName) {
    if (taxName == "declarationTax") {
      return "Steuererklärung";
    } else if (taxName == "safeTax") {
      return "safeTAX";
    }
    return "";
  }

  Row _rowTitleAndText(String title, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextComponent(
          "$title :",
          style:
              FontStyles.fontMedium(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        TextComponent(
          text,
          style: FontStyles.fontRegular(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  double calculatePercent(List<TaxStepsWrapper> taxSteps) {
    double percentage = 0;
    int approvedCount = 0;
    for (var element in taxSteps) {
      if (element.status == ProcessConstants.approved) {
        approvedCount = approvedCount + 1;
      }
    }
    return percentage = (approvedCount / taxSteps.length);
  }
}
