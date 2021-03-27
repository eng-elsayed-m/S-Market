import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/add_product_screen.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const nav = "/user-products";
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title:
              Text("My Products", style: Theme.of(context).textTheme.headline2),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add_box,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(AddProductScreen.nav))
          ],
        ),
        body: productsData.items.isEmpty
            ? Center(
                child: Text("No items been added",
                    style: Theme.of(context).textTheme.headline4),
              )
            : ListView.builder(
                itemCount: productsData.items.length,
                itemBuilder: (_, i) => UserProduct(
                  product: productsData.items[i],
                ),
              ));
  }
}
