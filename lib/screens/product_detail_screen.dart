import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const nav = "/product-detail";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final id = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(context).searchItem(id);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: CustomScrollView(
            semanticChildCount: 2,
            primary: true,
            slivers: [
              SliverAppBar(
                centerTitle: true,
                pinned: true,
                title: Text(
                  product.title,
                  style: Theme.of(context).textTheme.headline2,
                ),
                expandedHeight: MediaQuery.of(context).size.height * 0.6,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    // heght: MediaQuery.of(context).size.height * 0.7,
                    child: Hero(
                      tag: product.id,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // title: Text(product.title),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      child: GridTileBar(
                          backgroundColor: Colors.white,
                          leading: Text(
                            "Price :\$" + product.price.toString(),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          title: Text(
                            product.isFavorite ? "Favorite Item" : "",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Colors.red[900]),
                          ),
                          trailing: InkWell(
                            child: Icon(
                              Icons.shopping_basket,
                              color: Theme.of(context).accentColor,
                              size: 30,
                            ),
                            onTap: () {
                              cart.addItem(
                                  product.id, product.title, product.price);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                      content: Text(
                                        "Added to your Card !!",
                                        style: TextStyle(fontSize: 18),
                                      ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 10),
                      child: Center(
                        child: Text(
                          product.description,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 600,
                )
              ]))
            ],
          ),
        ));
  }
}
