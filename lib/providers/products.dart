import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shop_app/models/http_exception.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final authToken;
  final String userId;
  Products(this.authToken, this.userId);

  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((productItem) => productItem.isFavorite).toList();
  }

  Product searchItem(String id) {
    return _items.firstWhere((productItem) => productItem.id == id);
  }

  // getData(String uid, String token, List<Product> items) {
  //   _items = items;
  //   authToken = token;
  //   userId = uid;
  //   notifyListeners();
  // }

  Future<void> fetchProducts(bool filterUser) async {
    String filteringText =
        filterUser ? 'orderBy="creatorId"&equalTo="$userId"' : null;
    String url =
        'https://store-50499-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filteringText';
    try {
      final prodRes = await http.get(url);
      final prodResData = json.decode(prodRes.body) as Map<String, dynamic>;
      if (prodResData == null) {
        return;
      }
      url =
          "https://store-50499-default-rtdb.firebaseio.com/userFavorite/$userId.json?auth=$authToken";
      final favRes = await http.get(url);
      final favResData = json.decode(favRes.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      prodResData.forEach((prodId, product) {
        loadedProducts.add(Product(
          id: prodId,
          title: product["title"],
          description: product["description"],
          price: product["price"],
          imageUrl: product["imageUrl"],
          isFavorite: favResData == null ? false : favResData[prodId] ?? false,
        ));
        _items = loadedProducts;
        notifyListeners();
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        "https://store-50499-default-rtdb.firebaseio.com/products.json?auth=$authToken";
    try {
      final res = await http.post(url,
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
            "creatorId": userId,
          }));
      final newProduct = Product(
        id: json.decode(res.body)["name"],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> editProduct(String id, Product newProduct) async {
    final url =
        "https://store-50499-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";
    final editIndex = _items.indexWhere((prod) => prod.id == newProduct.id);
    final oldProduct = _items[editIndex];
    if (editIndex >= 0) {
      _items[editIndex] = newProduct;
      final res = await http.patch(url,
          body: json.encode({
            "title": newProduct.title,
            "description": newProduct.description,
            "price": newProduct.price,
            "imageUrl": newProduct.imageUrl,
          }));
      if (res.statusCode >= 400) {
        _items[editIndex] = oldProduct;
        throw HttpException("Item couldn't be edited");
      }
    }
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url1 =
        "https://store-50499-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";
    final url2 =
        "https://store-50499-default-rtdb.firebaseio.com/userFavorite/$userId/$id.json?auth=$authToken";
    final deleteIndex = _items.indexWhere((prod) => prod.id == id);
    var deletedProd = _items[deleteIndex];
    if (deleteIndex >= 0) {
      _items.removeAt(deleteIndex);
      notifyListeners();

      final res2 = await http.delete(url1).then((value) {
        http.delete(url2);
      });
      if (res2.statusCode >= 400) {
        _items.insert(deleteIndex, deletedProd);
        notifyListeners();
        throw HttpException("couldn't delete product");
      }
    }
    deletedProd = null;
  }
}
