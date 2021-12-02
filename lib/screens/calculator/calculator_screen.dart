import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: false,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AssetConstants.topRightRoundCircle),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AssetConstants.tax),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 35, right: 15, bottom: 20),
                    child: Text(
                      StringConstants.whatIsYourAnnualIncomeGoal,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 28),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'helvetica',
                          fontStyle: FontStyle.normal,
                          color: ColorConstants.black.withOpacity(0.4),
                        ),
                        label: const Text(StringConstants.annualIncom),
                        filled: false,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: ColorConstants.black.withOpacity(0.5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: ColorConstants.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, top: 15, right: 15, bottom: 15),
                      child: Text(
                        StringConstants.estimatedPrice,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                            child: Text(
                          "122euros",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 25),
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: ElevatedButton(
                      style: ElevatedButtonTheme.of(context).style?.copyWith(
                            minimumSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width, 70),
                            ),
                          ),
                      onPressed: () {},
                      child: const Text(
                        StringConstants.orderNew,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
