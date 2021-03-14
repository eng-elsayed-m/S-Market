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
      appBar: AppBar(title: Text("My Products"),actions: [
        IconButton(icon: Icon(Icons.add_box), onPressed: ()=> Navigator.of(context).pushNamed(AddProductScreen.nav))
      ],),
      body: ListView.builder(
      itemCount: productsData.items.length,
      itemBuilder: (_,i)=> UserProduct(product:productsData.items[i] ,
      ),)
    );
  }
}