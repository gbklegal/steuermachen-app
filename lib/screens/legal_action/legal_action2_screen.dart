import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:signature/signature.dart';

class LegalAction2Screen extends StatefulWidget {
  const LegalAction2Screen({Key? key}) : super(key: key);

  @override
  State<LegalAction2Screen> createState() => _LegalAction2ScreenState();
}

class _LegalAction2ScreenState extends State<LegalAction2Screen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.powerOfAttorney,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Text(
              StringConstants.discPowerOfAttorney,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(
              StringConstants.digitalSignature,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 25),
            Text(
              StringConstants.signHere,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Signature(
                controller: _controller,
                height: 300,
                backgroundColor: ColorConstants.formFieldBackground,
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
          onPressed: () {},
          child: const Text(
            StringConstants.send,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
