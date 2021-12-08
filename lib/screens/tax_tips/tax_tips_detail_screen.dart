import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/screens/tax_tips/tax_tips_top_component.dart';

class TaxTipsDetailScreen extends StatelessWidget {
  const TaxTipsDetailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String sampleText =
        """In 2021, pensioners will pay almost 100 billion euros in taxes and duties
POSTED ON NOVEMBER 15, 2021 BY DIANA PROSVIRKINA
Retirees, pension, old-age provision, double taxation
Reading time: 3 minutes
The year 2021 is not quite over yet, but something can already be gleaned from the forecast, which is based on the half-yearly figures. And it looks tough for the retirees! Just the health insurance contributions paid by retirees add up to an estimated EUR 46.1 billion.

 The tax burden has been increasing for years
At the request of the Left parliamentary group, the federal government announced the following figures for this year:

EUR 46.1 billion in health insurance contributions
EUR 41.8 billion income tax
EUR 8.8 billion long-term care insurance
The total is EUR 96.7 billion. In comparison, it was only EUR 71.3 billion in 2014.

The left-wing parliamentary group leader Dietmar Bartsch criticized such an increase and called it “unacceptable”.""";

    return Scaffold(
      body: AppBarWithSideCornerCircleAndRoundBody(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TaxTipTopComponent(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text(
                  sampleText,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
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
            Navigator.pushNamedAndRemoveUntil(
                context, RouteConstants.bottomNavBarScreen, (val) => false);
          },
          child: const Text(
            StringConstants.applyNow,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
