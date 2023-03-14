import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;

  const CartItem(
      {super.key,
      required this.id,
      required this.title,
      required this.quantity,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: FittedBox(child: Text('\$$price', style: TextStyle(color: Colors.white),)),
            ),
          ),
          subtitle: Text('Total Amount: \$${price * quantity}'),
          trailing: Text('x$quantity'),
        ),
      ),
    );
  }
}
