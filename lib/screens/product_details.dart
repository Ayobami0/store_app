import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = 'productDetailsScreen';

  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productInfo =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(productInfo.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                productInfo.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('\$${productInfo.amount}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  productInfo.description,
                  style: const TextStyle(),
                  textAlign: TextAlign.center,
                  softWrap: true,
                )),
          ],
        ),
      ),
    );
  }
}
