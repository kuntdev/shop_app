// ignore: avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/cart.dart';

import '/screens/cart_detail.dart';

import '/widgets/app_drawer.dart';
import '/widgets/badge.dart';
import '/widgets/products_grid.dart';

enum FilterOptions { favorites, all }

class ProductsOverView extends StatefulWidget {
  const ProductsOverView({Key? key}) : super(key: key);

  @override
  _ProductsOverViewState createState() => _ProductsOverViewState();
}

class _ProductsOverViewState extends State<ProductsOverView> {
  var _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ANIME SHOP'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showFavorites = true;
                } else {
                  _showFavorites = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Favorites'),
                value: FilterOptions.favorites,
              ),
              const PopupMenuItem(
                child: Text('All'),
                value: FilterOptions.all,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch!,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartDetail.routeName);
              },
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavorites),
    );
  }
}
