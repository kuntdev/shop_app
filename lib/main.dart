import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/products.dart';
import '/providers/cart.dart';
import '/providers/orders.dart';

import '/screens/product_detail.dart';
import '/screens/products_overview.dart';
import '/screens/cart_detail.dart';
import '/screens/orders_detail.dart';
import '/screens/user_products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.orange),
            fontFamily: 'Arial'),
        home: const ProductsOverView(),
        routes: {
          ProductDetail.routeName: (ctx) => ProductDetail(),
          CartDetail.routeName: (ctx) => CartDetail(),
          OrdersDetail.routeName: (ctx) => OrdersDetail(),
          UserProducts.routeName: (ctx) => UserProducts(),
        },
      ),
    );
  }
}
