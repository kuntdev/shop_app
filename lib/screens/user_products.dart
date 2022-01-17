import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/user_product_item.dart';

import '/providers/products.dart';

import '/widgets/app_drawer.dart';

class UserProducts extends StatelessWidget {
  static const String routeName = 'user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoır Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (context, index) => Column(
            children: [
              UserProductItem(productsData.items[index].title,
                  productsData.items[index].imageUrl),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
