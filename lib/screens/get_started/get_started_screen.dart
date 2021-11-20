import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ElevatedButton(
          // style: TextButtonTheme.of(context).style!.copyWith(
          //   // minimumSize: Size(MediaQuery.of(context).size.width, 48),
          // ),
          onPressed: () {},
          child: const Text("Get Started"),
        ),
      ),
    );
  }
}
