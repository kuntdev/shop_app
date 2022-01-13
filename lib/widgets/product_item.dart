import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/cart.dart';
import '/providers/product.dart';

import '/screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => {
            Navigator.of(context).pushNamed(
              ProductDetail.routeName,
              arguments: product.id,
            )
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: () => {
                product.toggleFavorite(),
              },
              icon: product.isFavourite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () => {
              cart.addItem(
                product.id,
                product.price,
                product.title,
              ),
              ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Added to cart!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              ),
            },
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
