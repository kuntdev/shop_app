// ignore: avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';

import '/widgets/products_grid.dart';

class ProductsOverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ANIME SHOP'),
        ),
        body: const ProductsGrid());
  }
}
