import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/add_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const nav = "/user-products";
  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: AppDrawer(),
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
      body: FutureBuilder(
          future:
              Provider.of<Products>(context, listen: false).fetchProducts(true),
          builder: (ctx, dataSnapshot) =>
              Consumer<Products>(builder: (ctx, productsData, _) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (dataSnapshot.error != null) {
                  return Center(
                      child: Text(
                    "an error occurred !",
                    style: Theme.of(context).textTheme.headline3,
                  ));
                } else {
                  return productsData.items.isEmpty
                      ? Center(
                          child: Text("No items been added",
                              style: Theme.of(context).textTheme.headline4),
                        )
                      : ListView.builder(
                          itemCount: productsData.items.length,
                          itemBuilder: (_, i) => UserProduct(
                            product: productsData.items[i],
                          ),
                        );
                }
              })),
    );
  }
}
