import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

class FileTaxInfoScreen extends StatefulWidget {
  FileTaxInfoScreen({Key? key}) : super(key: key);

  @override
  _FileTaxInfoScreenState createState() => _FileTaxInfoScreenState();
}

class _FileTaxInfoScreenState extends State<FileTaxInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.fillInfo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const TextProgressBarComponent(
                title: "${StringConstants.step} 4/5",
                progress: 0.8,
              ),
              const SizedBox(
                height: 62,
              ),
              TextComponent(
                StringConstants.surName,
                style: FontStyles.fontRegular(fontSize: 14),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: StringConstants.enterTitle,
                  hintStyle: FontStyles.fontRegular(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              TextComponent(
                StringConstants.firstName,
                style: FontStyles.fontRegular(fontSize: 14),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: StringConstants.enterTitle,
                  hintStyle: FontStyles.fontRegular(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              TextComponent(
                StringConstants.email,
                style: FontStyles.fontRegular(fontSize: 14),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: StringConstants.enterTitle,
                  hintStyle: FontStyles.fontRegular(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              TextComponent(
                StringConstants.road,
                style: FontStyles.fontRegular(fontSize: 14),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: StringConstants.enterTitle,
                  hintStyle: FontStyles.fontRegular(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 6,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          StringConstants.houseNo,
                          style: FontStyles.fontRegular(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: StringConstants.enterTitle,
                            hintStyle: FontStyles.fontRegular(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          StringConstants.postcode,
                          style: FontStyles.fontRegular(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: StringConstants.enterTitle,
                            hintStyle: FontStyles.fontRegular(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 6,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          StringConstants.place,
                          style: FontStyles.fontRegular(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: StringConstants.enterTitle,
                            hintStyle: FontStyles.fontRegular(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          StringConstants.phoneNo,
                          style: FontStyles.fontRegular(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: StringConstants.enterTitle,
                            hintStyle: FontStyles.fontRegular(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonComponent(
          buttonText: StringConstants.next,
          onPressed: () {
            Navigator.pushNamed(context, RouteConstants.fileTaxUploadDocScreen);
          },
        ),
      ),
    );
  }
}
