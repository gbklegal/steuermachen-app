import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/tax_advice_wrapper.dart';

class TaxAdviceScreen extends StatelessWidget {
  const TaxAdviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future: firestore.collection("tax_advice").doc("content").get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> x =
                  snapshot.data.data() as Map<String, dynamic>;
              TaxAdviceContentWrapper res = TaxAdviceContentWrapper.fromJson(x);
              return Scaffold(
                appBar: const AppBarComponent(
                  StringConstants.initialTaxAdvice,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Text(
                        StringConstants.pricing,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        StringConstants.chooseTheRightPrice,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 15),
                      if (context.locale == const Locale('en'))
                        _adviceCard(context, res.en!.title!, res.en!.subtitle!,
                            res.en!.price!)
                      else
                        _adviceCard(context, res.du!.title!, res.du!.subtitle!,
                            res.du!.price!),
                      const SizedBox(height: 25),
                      if (context.locale == const Locale('en'))
                        for (var i = 0; i < res.en!.advicePoints!.length; i++)
                          _advicePoints(context, res.en!.advicePoints![i])
                      else
                        for (var i = 0; i < res.du!.advicePoints!.length; i++)
                          _advicePoints(context, res.du!.advicePoints![i])
                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: AppConstants.bottomBtnPadding,
                  child: ElevatedButton(
                    style: ElevatedButtonTheme.of(context).style?.copyWith(
                          minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width, 70),
                          ),
                        ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteConstants.taxAdviceFormScreen);
                    },
                    child: const Text(
                      StringConstants.applyNowForAfee,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              );
              ;
            } else if (snapshot.hasError) {
              return const ErrorComponent();
            } else {
              return const LoadingComponent();
            }
          }),
    );
  }

  Padding _advicePoints(BuildContext context, String points) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2, right: 5),
            child: Icon(
              Icons.check_circle,
              size: 20,
              color: ColorConstants.toxicGreen,
            ),
          ),
          Flexible(
            child: Text(
              points,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  ClipRRect _adviceCard(
      BuildContext context, String title, String subtitle, String price) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Column(
        children: [
          Container(
            color: ColorConstants.formFieldBackground,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Image.asset(AssetConstants.taxAdvice),
                const SizedBox(width: 20),
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: ColorConstants.black.withOpacity(0.49),
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.white),
                  ),
                ),
                Text(
                  price,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
