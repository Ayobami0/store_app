import 'package:flutter/material.dart';
import 'package:store_app/models/products.dart';
import 'package:store_app/widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> products = [
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

  ProductOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MyStore')),
      body: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10),
          itemBuilder: ((ctx, i) {
            return ProductItem(
                id: products[i].id,
                title: products[i].title,
                url: products[i].imageUrl);
          })),
    );
  }
}
