import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatelessWidget {
  static const nav = "/edit-product";
  final _priceNode = FocusNode();
  final _descriptionNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final product = Provider.of<Products>(context).searchItem(id);

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text("Edit Prouct"),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: ListView(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(product.imageUrl),
                    radius: 80,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Title",
                  ),
                  initialValue: product.title,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceNode),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Price",
                  ),
                  initialValue: product.price.toString(),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceNode,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_descriptionNode),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Description",
                  ),
                  initialValue: product.description,
                  textInputAction: TextInputAction.next,
                  focusNode: _descriptionNode,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ));
  }
}
