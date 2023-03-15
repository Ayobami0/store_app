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
        onDismissed: (direction) {
          cart.removeItem(productId);
        },
        background: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.centerRight,
          color: Theme.of(context).errorColor,
          child: Icon(
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
                    builder: (ctx, cartItem, child) => Text('x${cartItem.items[productId]!.quantity}', style: TextStyle(fontSize: 30),)),
                  Column(
                    children: [
                      IconButton(onPressed: (){
                          cart.updateItem(false, productId);
                        }, icon: Icon(Icons.add, size: 40,)),
                      IconButton(onPressed: (){
                          if (quantity <= 1){
                            cart.removeItem(productId);
                          }
                          cart.updateItem(true, productId);
                        }, icon: Icon(Icons.remove, size: 40,)),
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
