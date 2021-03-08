import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(ProductDetailScreen.nav, arguments: product.id),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
              backgroundColor: Colors.white60,
              title: Text(
                product.title,
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              leading: InkWell(
                child: Icon(
                  product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: Colors.red[900],
                  size: 30,
                ),
                onTap: () {
                  product.toggleFav();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Added to your favorite !!"),
                    duration: Duration(seconds: 2),
                  ));
                },
              ),
              trailing: InkWell(
                child: Icon(
                  Icons.shopping_basket,
                  color: Theme.of(context).accentColor,
                  size: 30,
                ),
                onTap: () {
                  cart.addItem(product.id, product.title, product.price);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Theme.of(context).primaryColor,
                      content: Text("Added to your Card !!"),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: "UNDO",
                        onPressed: () {
                          cart.removeSingle(product.id);
                        },
                      )));
                },
              )),
        ),
      ),
    );
  }
}
