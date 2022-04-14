import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/data/view_models/payment_gateway/payment_gateway_provider.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/utils/card_validation/card_input_formatters.dart';
import 'package:steuermachen/utils/card_validation/card_validation_utils.dart';
import 'package:steuermachen/utils/input_validation_util.dart';
import 'package:steuermachen/wrappers/payment_gateway/sumpup_access_token_wrapper.dart';

class CardPaymentMethodScreen extends StatefulWidget {
  const CardPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<CardPaymentMethodScreen> createState() =>
      _CardPaymentMethodScreenState();
}

class _CardPaymentMethodScreenState extends State<CardPaymentMethodScreen> {
  late PaymentGateWayProvider provider;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController numberController = TextEditingController();
  final paymentCard = PaymentCard();
  var _autoValidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    provider = Provider.of<PaymentGateWayProvider>(context, listen: false);
    numberController.addListener(_getCardTypeFrmNumber);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      paymentCard.type = cardType;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fontStyle = FontStyles.fontRegular(fontSize: 14);
    const sizedBoxH12 = SizedBox(
      height: 12,
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: true,
        showPersonIcon: false,
        showBottomLine: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: Column(
            children: [
              Image.asset(AssetConstants.paymentMethods),
              sizedBoxH12,
              TextFormField(
                decoration: InputDecoration(
                  labelText: LocaleKeys.nameOnTheCard.tr() + "*",
                  hintStyle: fontStyle,
                ),
                onSaved: (val) => provider.userCardInfo.card?.name = val,
                validator: InputValidationUtil().validateName,
              ),
              sizedBoxH12,
              TextFormField(
                controller: numberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(19),
                  CardNumberInputFormatter()
                ],
                decoration: InputDecoration(
                    labelText: LocaleKeys.cardNumber.tr() + "*",
                    hintStyle: fontStyle,
                    suffixIcon: CardUtils.getCardIcon(paymentCard.type)),
                onSaved: (val) {
                  if (val != null) {
                    provider.userCardInfo.card?.number =
                        CardUtils.getCleanedNumber(val);
                  }
                },
                validator: CardUtils.validateCardNum,
              ),
              sizedBoxH12,
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        CardMonthInputFormatter()
                      ],
                      decoration: InputDecoration(
                        labelText: LocaleKeys.expiryDate.tr() + " ('MM/YY') *",
                        hintStyle: fontStyle,
                      ),
                      validator: CardUtils.validateDate,
                      keyboardType: TextInputType.number,
                      onSaved: (val) {
                        if (val != null) {
                          List<int> expiryDate = CardUtils.getExpiryDate(val);
                          provider.userCardInfo.card?.expiryMonth =
                              expiryDate[0].toString();
                          provider.userCardInfo.card?.expiryYear =
                              expiryDate[1].toString();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Flexible(
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      decoration: InputDecoration(
                        labelText: LocaleKeys.cv.tr() + "*",
                        hintStyle: fontStyle,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Image.asset(
                            AssetConstants.icCv,
                            height: 15,
                          ),
                        ),
                      ),
                      validator: CardUtils.validateCVV,
                      keyboardType: TextInputType.number,
                      onSaved: (val) {
                        provider.userCardInfo.card?.cvv = val;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppConstants.bottomBtnPadding,
        child: ButtonComponent(
          buttonText: LocaleKeys.continueText.tr(),
          onPressed: () async {
            final FormState form = _formKey.currentState!;
            if (!form.validate()) {
              setState(() {
                _autoValidateMode = AutovalidateMode
                    .always; // Start validating on every change.
              });
            } else {
              form.save();
              // await _tokenAndCheckOutRequest();
            }
            // Navigator.pushNamed(context, RouteConstants.confirmBillingScreen);
          },
        ),
      ),
    );
  }

  Future<void> _tokenAndCheckOutRequest() async {
    ApiResponse accessTokenRes = await provider.fetchAccessToken();
    if (accessTokenRes.status == Status.error) {
      ToastComponent.showToast(accessTokenRes.message!);
    } else {
      SumpupAccessTokenWrapper accessTokenWrapper =
          accessTokenRes.data as SumpupAccessTokenWrapper;
      ApiResponse createCheckoutRes =
          await provider.createCheckout(accessTokenWrapper.accessToken, 10);
      print(createCheckoutRes);
    }
  }
}
