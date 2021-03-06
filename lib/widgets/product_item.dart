import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(ProductDetailScreen.nav, arguments: product.id),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GridTile(
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/holder.png'),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
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
                  product.toggleFav(auth.userId, auth.token);
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
                      backgroundColor: Theme.of(context).accentColor,
                      content: Text("Added to your Card !!",
                          style: TextStyle(fontSize: 18)),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: "UNDO",
                        textColor: Colors.white,
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
