import 'package:flutter/foundation.dart';

import './product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    Product(
      id: 'product1',
      title: 'Product 1',
      description: 'This is the description for Product 1',
      amount: 50.00,
      imageUrl: 'https://picsum.photos/200/300',
      isFavourite: false,
    ),
    Product(
      id: 'product2',
      title: 'Product 2',
      description: 'This is the description for Product 2',
      amount: 75.99,
      imageUrl: 'https://picsum.photos/200/300',
      isFavourite: true,
    ),
    Product(
      id: 'product3',
      title: 'Product 3',
      description: 'This is the description for Product 3',
      amount: 15.00,
      imageUrl: 'https://picsum.photos/200/300',
      isFavourite: true,
    ),
    Product(
      id: 'product4',
      title: 'Product 4',
      description: 'This is the description for Product 4',
      amount: 42.50,
      imageUrl: 'https://picsum.photos/200/300',
      isFavourite: false,
    ),
    Product(
      id: 'product5',
      title: 'Product 5',
      description: 'This is the description for Product 5',
      amount: 99.99,
      imageUrl: 'https://picsum.photos/200/300',
      isFavourite: false,
    ),
  ];

  List<Product> get favouriteItems{
    return _items.where((element) => element.isFavourite).toList();
  }

  List<Product> get items => [..._items];

  Product findById(id){
    return _items.firstWhere((product) => product.id == id);
  }

  void addProducts(){
    // _items.add(value);
    notifyListeners();
  }
}
