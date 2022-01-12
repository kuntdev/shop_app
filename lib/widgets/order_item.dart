import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem orderItem;

  OrderItem({required this.orderItem});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(
              DateFormat('dd-MM-yyyy hh:mm').format(widget.orderItem.createdOn),
            ),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                )),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.all(10),
              height: min(
                widget.orderItem.products.length * 30.0 + 10,
                180,
              ),
              child: ListView.builder(
                itemCount: widget.orderItem.products.length,
                itemBuilder: (ctx, i) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.orderItem.products[i].title,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '${widget.orderItem.products[i].quantity}\t x\t \$${widget.orderItem.products[i].price}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
