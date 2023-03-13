import 'dart:html';

import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String url;
  const ProductItem(
      {super.key, required this.id, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      // ignore: sort_child_properties_last
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        trailing: IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){}),
        leading: IconButton(icon: Icon(Icons.favorite), onPressed: (){}),
        backgroundColor: Colors.black54,
          title: Text(
        title,
        textAlign: TextAlign.center,
      )),
    );
  }
}
