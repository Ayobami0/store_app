import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  const CartItem(
      {super.key,
      required this.id,
      required this.productId,
      required this.title,
      required this.quantity,
      required this.price});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: ValueKey(id),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction){
          return showDialog(
            context: context,
            builder: (ctx) => const CustomConfirmationDialog());
        },
        onDismissed: (direction) {
          cart.removeItem(productId);
        },
        background: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.centerRight,
          color: Theme.of(context).errorColor,
          child: const Icon(
            Icons.delete,
            size: 40,
          ),
        ),
        child: Card(
          child: ListTile(
            title: Text(title),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: FittedBox(
                    child: Text(
                  '\$$price',
                  style: const TextStyle(color: Colors.white),
                )),
              ),
            ),
            subtitle: Text('Total Amount: \$${price * quantity}'),
            trailing: FittedBox(
              child: Row(
                children: [
                  Consumer<Cart>(
                    builder: (ctx, cartItem, child) => Text('x${cartItem.items[productId]!.quantity}', style: const TextStyle(fontSize: 30),)),
                  Column(
                    children: [
                      IconButton(onPressed: (){
                          cart.updateItem(true, productId);
                        }, icon: const Icon(Icons.add, size: 40,)),
                      IconButton(onPressed: (){
                          cart.updateItem(false, productId);
                        }, icon: const Icon(Icons.remove, size: 40,)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomConfirmationDialog extends StatelessWidget {
  const CustomConfirmationDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Do you want to remove the item from your cart'),
      actions: [
        TextButton(onPressed: (){
            Navigator.of(context).pop(false);
          }, child: const Text('No')),
        TextButton(onPressed: (){
            Navigator.of(context).pop(true);
          }, child: const Text('Yes'))
      ],
          );
  }
}
