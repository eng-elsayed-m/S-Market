// import 'dart:convert';
import 'package:flutter/foundation.dart';
// import 'package:shop_app/models/http_exception.dart';
import 'product.dart';
// import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  String authToken;
  String userId;

  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p5',
      title: 'black Shirt',
      description: 'A black shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p6',
      title: 'black Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p7',
      title: 'red Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p8',
      title: 'A Platin Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p9',
      title: 'white Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p10',
      title: 'A classic  Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((productItem) => productItem.isFavorite).toList();
  }

  Product searchItem(String id) {
    return _items.firstWhere((productItem) => productItem.id == id);
  }

  //   getData(String uid, String token, List<Product> items) {
  //   _items = items;
  //   authToken = token;
  //   uid = userId;
  //   notifyListeners();
  // }
  // Future<void> fetchProducts([bool filterUser = false]) async {
  //   String filteringText =
  //       filterUser ? "orderBy = 'creatorID'&equalTo=$userId" : null;
  //   String url =
  //       "https://store-50499-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filteringText";
  //   try {
  //     final prodRes = await http.get(url);
  //     final prodResData = json.decode(prodRes.body) as Map<String, dynamic>;
  //     if (prodResData == null) {
  //       return;
  //     }
  //     url =
  //         "https://store-50499-default-rtdb.firebaseio.com/userFavorite/$userId.json?auth=$authToken";
  //     final favRes = await http.get(url);
  //     final favResData = json.decode(favRes.body);
  //     final List<Product> loadedProducts = [];
  //     prodResData.forEach((prodId, product) {
  //       loadedProducts.add(Product(
  //         id: prodId,
  //         title: prodResData["title"],
  //         description: prodResData["description"],
  //         price: prodResData["price"],
  //         imageUrl: prodResData["imageUrl"],
  //         isFavorite: favResData == null ? false : favResData[prodId] ?? false,
  //       ));
  //       _items = loadedProducts;
  //       notifyListeners();
  //     });
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<void> addProduct(Product product) async {
  //   try {
  //     final res = await http.post(json.encode({
  //       "id": product.id,
  //       "title": product.title,
  //       "description": product.description,
  //       "price": product.price,
  //       "imageUrl": product.imageUrl,
  //       "creatorId": userId,
  //     }));
  //     final Product newProduct = Product(
  //       id: json.decode(res.body)["name"],
  //       title: product.title,
  //       description: product.description,
  //       price: product.price,
  //       imageUrl: product.imageUrl,
  //     );
  //     _items.add(newProduct);
  //     notifyListeners();
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<void> editProduct(String id, Product newProduct) async {
  //   final editIndex = _items.indexWhere((prod) => prod.id == newProduct.id);
  //   if (editIndex >= 0) {
  //     try {
  //       final url =
  //           "https://store-50499-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";
  //       await http.patch(url,
  //           body: json.encode({
  //             "title": newProduct.title,
  //             "description": newProduct.description,
  //             "price": newProduct.price,
  //             "imageUrl": newProduct.imageUrl,
  //           }));
  //       _items[editIndex] = newProduct;
  //       notifyListeners();
  //     } catch (e) {
  //       throw e;
  //     }
  //   }
  // }

  // Future<void> deleteProduct(String id) async {
  //   final url =
  //       "https://store-50499-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";
  //   final deleteIndex = _items.indexWhere((prod) => prod.id == id);
  //   var deletedProd = _items[deleteIndex];
  //   if (deleteIndex >= 0) {
  //     _items.removeAt(deleteIndex);
  //     notifyListeners();

  //     final res = await http.delete(url);
  //     if (res.statusCode >= 400) {
  //       _items.insert(deleteIndex, deletedProd);
  //       notifyListeners();
  //       throw HttpException("couldn't delete product");
  //     }
  //   }
  //   deletedProd = null;
  // }
}
