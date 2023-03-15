import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/screens/cart.dart';
import 'package:store_app/widgets/badge.dart';

import '../providers/cart.dart';
import '../widgets/drawer.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  favourites,
  all
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('MyStore'),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, c) => Badge(
                value: cart.itemCount,
                child: c!),
            child: IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
            },),
          ),
          PopupMenuButton(
            onSelected: (value) {
              if (value == FilterOptions.favourites) {
                setState(() {
                  _showFavourites = true;          
                });
              }
              else{
                setState(() {
                  _showFavourites = false;                  
                });
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(value: FilterOptions.favourites,child: Text('Only Favourites'),),
              const PopupMenuItem(value: FilterOptions.all,child: Text('All'),)
            ],
          )
        ],
      ),
      body: ProductsGrid(_showFavourites),
    );
  }
}

