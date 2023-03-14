import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import './product_item.dart';


class ProductsGrid extends StatelessWidget {
  final bool showFavouriteOnly;
  const ProductsGrid(this.showFavouriteOnly, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavouriteOnly ? productsData.favouriteItems : productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10),
        itemBuilder: ((ctx, i) {
          return ChangeNotifierProvider.value(
            value: products[i],
            child: const ProductItem(
          ),
          );
        }));
  }
}
