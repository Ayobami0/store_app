import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
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

  Future fetchOrders() async {
    const url =
        'https://weighty-arch-380111-default-rtdb.firebaseio.com/orders.json';
    try {
      final response = await http.get(Uri.parse(url));
      Map<String, dynamic> extractedData = json.decode(response.body);
      List<OrderModel> loadedOrders = [];
      extractedData.forEach((orderId, orderData) {
        List storedOrderList = json.decode(orderData['orderList']);
        loadedOrders.add(OrderModel(
            id: orderId,
            amount: orderData['amount'],
            orderList: storedOrderList
                .map((e) => CartItem(
                    id: e['id'],
                    title: e['title'],
                    quantity: e['quantity'],
                    price: e['price']))
                .toList(),
            dateTime: DateTime.parse(orderData['dateTime'])));
      });
      _orders = loadedOrders;
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future addOrders(List<CartItem> cartItems, double total) async {
    const url =
        'https://weighty-arch-380111-default-rtdb.firebaseio.com/orders.json';
    try {
      List cartItemsList = cartItems
          .map((e) => {
                'id': e.id,
                'title': e.title,
                'price': e.price,
                'quantity': e.quantity,
              })
          .toList();

      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'amount': total,
            'orderList': json.encode(cartItemsList),
            'dateTime': DateTime.now().toString()
          }));
      _orders.insert(
          0,
          OrderModel(
              id: json.decode(response.body)['name'],
              amount: total,
              orderList: cartItems,
              dateTime: DateTime.now()));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
