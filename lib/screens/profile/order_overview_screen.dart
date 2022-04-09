import 'package:flutter/material.dart';
import 'package:steuermachen/components/no_order_component.dart';

class OrderOverviewScreen extends StatelessWidget {
  const OrderOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NoOrderComponent(),
    );
  }
}
