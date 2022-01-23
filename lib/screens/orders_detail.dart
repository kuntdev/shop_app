import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/orders.dart' show Orders;

import '/widgets/order_item.dart';
import '/widgets/app_drawer.dart';

class OrdersDetail extends StatefulWidget {
  static const String routeName = 'order-detail';

  @override
  State<OrdersDetail> createState() => _OrdersDetailState();
}

class _OrdersDetailState extends State<OrdersDetail> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAllData();
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (context, index) => OrderItem(
                orderItem: orderData.orders[index],
              ),
            ),
    );
  }
}
