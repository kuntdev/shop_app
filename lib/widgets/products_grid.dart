import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/products.dart';
import '/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  // ignore: use_key_in_widget_constructors
  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    var productContainer = Provider.of<Products>(context);
    var products =
        showFavs ? productContainer.favoriteItems : productContainer.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0),
    );
  }
}
