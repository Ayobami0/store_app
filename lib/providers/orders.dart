import 'package:flutter/foundation.dart';
import 'package:store_app/providers/cart.dart';

class OrderModel {
  final String id;
  final double amount;
  final List<CartItem> orderList;
  final DateTime dateTime;

  OrderModel(
      {required this.id,
      required this.amount,
      required this.orderList,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders => [..._orders];

  void addOrders(List<CartItem> cartItems, double total) {
    _orders.insert(
        0,
        OrderModel(
            id: DateTime.now().toString(),
            amount: total,
            orderList: cartItems,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
