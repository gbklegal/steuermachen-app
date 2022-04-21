import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/signature/signature_provider.dart';

class SignatureComponent extends StatefulWidget {
  const SignatureComponent({Key? key}) : super(key: key);

  @override
  _SignatureComponentState createState() => _SignatureComponentState();
}

class _SignatureComponentState extends State<SignatureComponent> {
  late SignatureProvider signatureProvider;
  @override
  void initState() {
    signatureProvider = Provider.of<SignatureProvider>(context, listen: false);
    signatureProvider.clearSignature();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.powerOfAttorney.tr(),
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        Text(
          LocaleKeys.digitalSignature.tr(),
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.signHere.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            InkWell(
              onTap: () {
                signatureProvider.clearSignature();
              },
              child: Text(
                LocaleKeys.clear.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Signature(
            controller: signatureProvider.controller,
            height: 300,
            backgroundColor: ColorConstants.formFieldBackground,
          ),
        )
      ],
    );
  }
}
