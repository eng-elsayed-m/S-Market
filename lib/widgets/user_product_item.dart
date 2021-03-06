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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(ProductDetailScreen.nav, arguments: product.id),
        child: Card(
          color: Color(0xFF30475e),
          elevation: 7,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(product.imageUrl),
              radius: 35,
            ),
            title: Text(
              product.title,
              style: Theme.of(context).textTheme.headline4,
            ),
            subtitle: Text(
              "\$" + product.price.toString(),
              style: Theme.of(context).textTheme.headline5,
            ),
            trailing: Container(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xFFf05454),
                      ),
                      onPressed: () => Navigator.of(context).pushNamed(
                          EditProductScreen.nav,
                          arguments: product.id)),
                  IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[900],
                      ),
                      onPressed: () => showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              content:
                                  Text("Sure you wanna delete this item ?!"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Provider.of<Products>(context,
                                              listen: false)
                                          .deleteProduct(product.id);
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text("Delete")),
                                TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(),
                                    child: Text("No"))
                              ],
                            ),
                          ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
