import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String url;
  const ProductItem(
      {super.key, required this.id, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        // ignore: sort_child_properties_last
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: (){},
            color: Theme.of(context).colorScheme.secondary,
            ),
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: (){}),
          backgroundColor: Colors.black87,
            title: Text(
          title,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
