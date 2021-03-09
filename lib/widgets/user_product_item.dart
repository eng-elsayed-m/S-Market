import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProduct extends StatelessWidget {
  final Product product;

  const UserProduct({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      elevation: 7,
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl),),
        title: Text(product.title),
        trailing: Container(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            IconButton(icon: Icon(Icons.edit,color: Theme.of(context).accentColor,), onPressed: ()=> Navigator.of(context).pushNamed(EditProductScreen.nav,arguments: product.id)),
            IconButton(icon: Icon(Icons.delete,color: Colors.red[900],), onPressed: (){})
          ],),
        ),
      ),
    );
  }
}
