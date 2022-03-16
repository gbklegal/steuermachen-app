import 'package:flutter/material.dart';

class SimpleErrorTextComponent extends StatelessWidget {
  const SimpleErrorTextComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: Text('Something went wrong'),
      ),
    );
  }
}