import 'package:flutter/material.dart';

import '../screens/orders.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text('MyStore'),
          ),
          ListTile (
            leading: const Icon(Icons.shop),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            title: const Text('Products'),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart_checkout),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
            title: const Text('Orders'),
          )
        ],
      ),
    );
  }
}
