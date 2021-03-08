import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> _items, double total) {
    _orders.insert(
        0,
        OrderItem(
            amount: total,
            id: DateTime.now().toString(),
            dateTime: DateTime.now(),
            products: _items));
    notifyListeners();
  }

  void removeItem(String id) {
    _orders.remove(id);
    notifyListeners();
  }
}
