import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/orders.dart';
import 'package:store_app/widgets/order_item.dart';

import '../widgets/drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final  orderData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(itemCount: orderData.orders.length, itemBuilder: (ctx, i) => OrderItem(order: orderData.orders[i],)),
    );
  }
}
