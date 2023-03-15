import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_app/providers/orders.dart';

class OrderItem extends StatefulWidget {
  final OrderModel order;

  const OrderItem({super.key, required this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd, MMM yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: _expanded
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              height: min(widget.order.orderList.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.order.orderList
                    .map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text('${e.quantity.toString()}x \$${e.price.toString()}')
                          ],
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
