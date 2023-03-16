import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_details.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(ProductDetailsScreen.routeName, arguments: product.id),
        child: GridTile(
          footer: GridTileBar(
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: (){
                cart.addItem(product.id, product.amount, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Item added to cart'),
                    action: SnackBarAction(label: 'UNDO', onPressed: (){
                        cart.updateItem(false, product.id);
                    },),
                  )
                );
              },
              color: Theme.of(context).colorScheme.secondary,
              ),
            leading: Consumer<Product>(
              builder: (context, product, child) => IconButton(
                color: Theme.of(context).colorScheme.secondary,
                icon: Icon(product.isFavourite ? Icons.favorite : Icons.favorite_border_rounded),
                onPressed: (){
                  product.toggleFavouriteStatus();
                }),
            ),
            backgroundColor: Colors.black87,
              title: Text(
            product.title,
            textAlign: TextAlign.center,
          )),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
