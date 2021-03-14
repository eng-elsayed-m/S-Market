import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class UserProduct extends StatelessWidget {
  final Product product;

  const UserProduct({@required this.product});

  @override 
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Navigator.of(context).pushNamed(ProductDetailScreen.nav,arguments: product.id),
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 7,
        child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl),radius: 30,),
          title: Text(product.title,style: Theme.of(context).textTheme.headline4,),
          subtitle: Text("\$"+product.price.toString(),style: Theme.of(context).textTheme.headline5,),
          trailing: Container(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              IconButton(icon: Icon(Icons.edit,color: Theme.of(context).accentColor,), onPressed: ()=> Navigator.of(context).pushNamed(EditProductScreen.nav,arguments: product.id)),
              IconButton(icon: Icon(Icons.delete,color: Colors.red[900],), onPressed: ()=> Provider.of<Products>(context,listen: false).deleteProduct(product.id))
            ],),
          ),
        ),
      ),
    );
  }
}
