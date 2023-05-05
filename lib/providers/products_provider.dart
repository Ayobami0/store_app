import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_app/models/http_exception.dart';

import './product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    // Product(
    //   id: 'product1',
    //   title: 'Product 1',
    //   description: 'This is the description for Product 1',
    //   amount: 50.00,
    //   imageUrl: 'https://picsum.photos/200/300',
    //   isFavourite: false,
    // ),
    // Product(
    //   id: 'product2',
    //   title: 'Product 2',
    //   description: 'This is the description for Product 2',
    //   amount: 75.99,
    //   imageUrl: 'https://picsum.photos/200/300',
    //   isFavourite: true,
    // ),
    // Product(
    //   id: 'product3',
    //   title: 'Product 3',
    //   description: 'This is the description for Product 3',
    //   amount: 15.00,
    //   imageUrl: 'https://picsum.photos/200/300',
    //   isFavourite: true,
    // ),
    // Product(
    //   id: 'product4',
    //   title: 'Product 4',
    //   description: 'This is the description for Product 4',
    //   amount: 42.50,
    //   imageUrl: 'https://picsum.photos/200/300',
    //   isFavourite: false,
    // ),
    // Product(
    //   id: 'product5',
    //   title: 'Product 5',
    //   description: 'This is the description for Product 5',
    //   amount: 99.99,
    //   imageUrl: 'https://picsum.photos/200/300',
    //   isFavourite: false,
    // ),
  ];

  Future fetchProducts() async {
    const uri =
        'https://weighty-arch-380111-default-rtdb.firebaseio.com/products.json';

    try {
      final response = await http.get(Uri.parse(uri));
      Map<String, dynamic> extractedData = json.decode(response.body);
      List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            amount: prodData['amount'],
            imageUrl: prodData['imageUrl']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  List<Product> get items => [..._items];

  Product findById(id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> addProducts(Product product) async {
    const url =
        'https://weighty-arch-380111-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'amount': product.amount,
            'imageUrl': product.imageUrl,
            'isFavourite': product.isFavourite
          }));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          amount: product.amount,
          imageUrl: product.imageUrl);

      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future updateProducts(String productId, Product updatedProduct) async{
    int productIndex = _items.indexWhere((element) => element.id == productId);
    if (productIndex >= 0) {
      final uri =
          'https://weighty-arch-380111-default-rtdb.firebaseio.com/products/$productId.json';
      await http.patch(Uri.parse(uri), body: json.encode(
          {
            'title': updatedProduct.title,
            'description': updatedProduct.description,
            'amount': updatedProduct.amount,
            'imageUrl': updatedProduct.imageUrl,
          }
      ));
      _items[productIndex] = updatedProduct;
      notifyListeners();
    }
  }

  Future deleteProduct(String productId) async{
    final uri =
        'https://weighty-arch-380111-default-rtdb.firebaseio.com/products/$productId.';
    final existingProductIndex = _items.indexWhere((element) => element.id == productId);
    Product? existingProduct = _items[existingProductIndex];

    _items.removeWhere((element) => element.id == productId);
    notifyListeners();

    final response = await http.delete(Uri.parse(uri));

    if (response.statusCode >= 400){
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw const HttpException(message: 'Could not delete product');
    }
    existingProduct = null;
  }
}
