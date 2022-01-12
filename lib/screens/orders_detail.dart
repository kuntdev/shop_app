import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/orders.dart' show Orders;

import '/widgets/order_item.dart';
import '/widgets/app_drawer.dart';

class OrdersDetail extends StatelessWidget {
  static const String routeName = 'order-detail';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => OrderItem(
          orderItem: orderData.orders[index],
        ),
      ),
    );
  }
}
