// import 'dart:convert';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  void setFavVal(bool isFav) {
    isFavorite = isFav;
    notifyListeners();
  }

  Future<void> toggleFav() async {
    isFavorite = !isFavorite;
    notifyListeners();
    // final oldState = isFavorite;
    //  final url =         "https://store-50499-default-rtdb.firebaseio.com/products/$userId/$id.json?auth=$token";
    // try {
    //   final resp = await http.put(url,body:json.encode(isFavorite));
    //   if (resp.statusCode >= 400) {
    //     setFavVal(oldState);
    //     notifyListeners();
    //   }
    // } catch (e) {
    //   setFavVal(oldState);
    //   throw e;
    // }
  }
}
