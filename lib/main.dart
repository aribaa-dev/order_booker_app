import 'package:flutter/material.dart';

import 'package:order_booker/features/dashboard/presentation/screens/dashboard_screen.dart';

import 'package:order_booker/features/order_managment/presentation/screens/order_management_screen.dart';
import 'package:order_booker/features/settings/presentation/screens/setting_screen.dart';

void main() {
  runApp(const OrderBooker());
}

class OrderBooker extends StatefulWidget {
  const OrderBooker({super.key});

  @override
  State<OrderBooker> createState() => _OrderBookerState();
}

class _OrderBookerState extends State<OrderBooker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}
