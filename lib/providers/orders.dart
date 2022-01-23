import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '/providers/cart.dart';

import '/contants.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime createdOn;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.createdOn,
  });
}

class Orders with ChangeNotifier {
  static const _firebaseRepoName = 'orders.json';
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAllData() async {
    final url = Uri.parse(FIREBASE_URL + _firebaseRepoName);
    try {
      final response = await http.get(url);
      final List<OrderItem> loadedOrders = [];
      print(json.decode(response.body));
      final extractedItems = json.decode(response.body) as Map<String, dynamic>;
      if (extractedItems == null) {
        return;
      }
      extractedItems.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            createdOn: DateTime.parse(orderData['createdOn']),
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                      id: item['id'],
                      title: item['title'],
                      price: item['price'],
                      quantity: item['quantity'],
                    ))
                .toList(),
          ),
        );
      });
      _orders = loadedOrders;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(FIREBASE_URL + _firebaseRepoName);
    final timeStamp = DateTime.now();

    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'createdOn': timeStamp.toIso8601String(),
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'price': cp.price,
                      'quantity': cp.quantity
                    })
                .toList(),
          }));

      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          createdOn: timeStamp,
        ),
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {}
  }
}
