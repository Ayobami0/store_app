import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/cart.dart' show Cart;
import 'package:store_app/providers/orders.dart';

import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cartScreen';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isPlaced = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: ((ctx, index) => CartItem(
                  productId: cart.items.keys.toList()[index],
                  id: cart.items.values.toList()[index].id,
                  title: cart.items.values.toList()[index].title,
                  quantity: cart.items.values.toList()[index].quantity,
                  price: cart.items.values.toList()[index].price)),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total: ',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                      onPressed: () {
                        _isPlaced = true;
                        Provider.of<Orders>(context, listen: false)
                            .addOrders(
                                cart.items.values.toList(), cart.totalAmount)
                            .then((_) {
                          showDialog(
                              context: context,
                              builder: (ctx) => const OrderPlacedDialog());
                          setState(() {
                            _isPlaced = false;
                          });
                        });
                        cart.clear();
                      },
                      child: _isPlaced
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text('ORDER NOW',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              )))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderPlacedDialog extends StatelessWidget {
  const OrderPlacedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Success'),
      content: const Text('Order Placed Successfully'),
      actions: [
        ElevatedButton(
            onPressed: Navigator.of(context).pop, child: const Text('Close'))
      ],
    );
  }
}
