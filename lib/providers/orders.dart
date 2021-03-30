import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shop_app/models/http_exception.dart';
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
  final authToken;
  final userId;
  Orders(this.authToken,this.userId);
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url =
        "https://store-50499-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken";
    final res = await http.get(url);
    final resData = json.decode(res.body) as Map<String, dynamic>;
    if (resData == null) {
      return;
    }
    List<OrderItem> loadedOrders = [];
    resData.forEach((id, order) {
      loadedOrders.insert(
          0,
          OrderItem(
              id: id,
              amount: order["amount"],
              products: (order["products"] as List<dynamic>)
                  .map((item) => CartItem(
                      id: item["id"],
                      price: item["price"],
                      quantity: item["quantity"],
                      title: item["title"]))
                  .toList(),
              dateTime: DateTime.parse(order["dateTime"])));
    });
    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> _items, double total) async {
    final url =
        "https://store-50499-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken";
    final timestamp = DateTime.now();
    final res = await http.post(url,
        body: json.encode({
          "amount": total,
          "dateTime": timestamp.toIso8601String(),
          "products": _items
              .map((cartProd) => {
                    "id": cartProd.id,
                    "title": cartProd.title,
                    "quantity": cartProd.quantity,
                    "price": cartProd.price,
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
            amount: total,
            id: json.decode(res.body)["name"],
            dateTime: timestamp,
            products: _items));
    notifyListeners();
  }

  Future<void> removeItem(String id) async {
    final url =
        "https://store-50499-default-rtdb.firebaseio.com/orders/$userId/$id.json?auth=$authToken";
    final deleteIndex = _orders.indexWhere((order) => order.id == id);
    OrderItem deletedOrder = _orders[deleteIndex];
    if (deleteIndex >= 0) {
      _orders.removeAt(deleteIndex);
      notifyListeners();
      final res = await http.delete(url);
      if (res.statusCode >= 400) {
        _orders.insert(deleteIndex, deletedOrder);
        notifyListeners();
        throw HttpException("couldn't delete product");
      }
    }
    deletedOrder = null;
  }
}
