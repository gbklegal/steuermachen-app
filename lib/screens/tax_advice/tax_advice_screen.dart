import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

class TaxAdviceScreen extends StatelessWidget {
  const TaxAdviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(
              StringConstants.chooseTheRightPrice,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 15),
            _adviceCard(context),
            const SizedBox(height: 25),
            for (var i = 0; i < 5; i++)
              Padding(
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
                    Text(
                      "individually",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ElevatedButton(
          style: ElevatedButtonTheme.of(context).style?.copyWith(
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 70),
                ),
              ),
          onPressed: () {
            
          },
          child: const Text(
            StringConstants.applyNowForAfee,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  ClipRRect _adviceCard(BuildContext context) {
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
                    StringConstants.taxEasyNow,
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
                    StringConstants.onlyForInitialTax,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.white),
                  ),
                ),
                Text(
                  "49.00€",
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
