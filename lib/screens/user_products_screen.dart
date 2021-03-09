import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/user_product_item.dart';
class UserProductsScreen extends StatelessWidget {
  static const nav = "/user-products";
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: Text("My Products"),),
      backgroundColor: Theme.of(context).accentColor,
      body: Padding(padding: EdgeInsets.all(15),
          child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_,i)=> UserProduct(product:productsData.items[i] ,
          ),),
      )
    );
  }
}