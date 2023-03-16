import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/products_provider.dart';
import 'package:store_app/screens/create_product.dart';
import 'package:store_app/widgets/drawer.dart';

import '../widgets/users_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/userProductsScreen';
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            }, icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) {
            return UserProductItems(product: productsData.items[i]);
          }
        ),
      ),
    );
  }
}

