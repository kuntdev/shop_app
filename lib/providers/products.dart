import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/contants.dart';
import 'product.dart';

class Products with ChangeNotifier {
  static const _firebaseRepoName = 'products.json';

  // ignore: prefer_final_fields
  List<Product> _items = [
    // Product(
    //     id: 'p1',
    //     title: 'zoro',
    //     description: 'one piece : roronoa zoro figure',
    //     price: 10.0,
    //     imageUrl:
    //         'https://n11scdn.akamaized.net/a1/1024/ev-yasam/hediyelik-esya/roronoa-zoro-anime-figur__0356218032215912.jpg'),
    // Product(
    //     id: 'p2',
    //     title: 'hiyori',
    //     description: 'one piece : hiyori figure',
    //     price: 5.0,
    //     imageUrl:
    //         'https://bbts1.azureedge.net/images/p/full/2020/10/da9ab6e1-12e1-4d9d-8c34-669d8562f924.jpg'),
    // Product(
    //     id: 'p3',
    //     title: 'luffy',
    //     description: 'one piece : luffy figure',
    //     price: 12.0,
    //     imageUrl:
    //         'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQFhannZ7jMpDYDCx3xz2HbG572dHoJ-bplW20jUUqdkqiYeJn8N1PHSKKje8ccfNzUKGfnEDj7LVio7ncR31N0FGQFDySBzgRa5MJEOBbMrVyM4NsNxwsgCw&usqp=CAE'),
    // Product(
    //     id: 'p4',
    //     title: 'boa hancock',
    //     description: 'one piece : boa hancock figure',
    //     price: 8.0,
    //     imageUrl:
    //         'https://img.joomcdn.net/5ca07d09f31a9d849b52a6b95328f568db55ee7c_original.jpeg'),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    final retVal = _items.where((element) => element.isFavourite).toList();
    return retVal;
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAllData() async {
    final url = Uri.parse(FIREBASE_URL + _firebaseRepoName);
    try {
      final response = await http.get(url);
      // ignore: avoid_print
      // print(json.decode(response.body));
      List<Product> loadedProducts = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((productId, productData) {
        loadedProducts.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavourite: productData['isFavourite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(FIREBASE_URL + _firebaseRepoName);
    try {
      final response = await http.post(url,
          body: json.encode(
            {
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'isFavourite': product.isFavourite,
              'price': product.price
            },
          ));
      _items.add(
        Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        ),
      );
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void deleteProduct(String id) async {
    final url = Uri.parse(FIREBASE_URL + 'products/$id.json');
    await http.delete(url).then((_) {
      _items.removeWhere((element) => element.id == id);
    });
    notifyListeners();
  }
}
