import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return _items;
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double _totalAmount = 0;
    _items.forEach((key, item) {
      _totalAmount += item.price * item.quantity;
    });
    return _totalAmount;
  }

  void addItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (cart) => CartItem(
              title: cart.title,
              price: cart.price,
              id: cart.id,
              quantity: cart.quantity + 1));
    } else {
      _items.putIfAbsent(
          id, () => CartItem(id: id, title: title, price: price, quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String cartId) {
    _items.remove(cartId);
    notifyListeners();
  }

  void removeSingle(String id) {
    if (_items.containsKey(id)) {
      if (_items[id].quantity == 1) {
        _items.remove(id);
      } else {
        _items.update(
            id,
            (exCart) => CartItem(
                id: exCart.id,
                title: exCart.title,
                quantity: exCart.quantity - 1,
                price: exCart.price));
      }
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
