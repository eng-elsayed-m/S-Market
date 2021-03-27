import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatefulWidget {
  static const nav = "/product-detail";

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final id = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(context).searchItem(id);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(product.title,style: Theme.of(context).textTheme.headline2,),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              child: GridTile(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.contain,
                ),
                footer: GridTileBar(
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
                        cart.addItem(product.id, product.title, product.price);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Theme.of(context).accentColor,
                      content: Text("Added to your Card !!",style: TextStyle(fontSize: 18),),
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
          ),
          Expanded(
            flex:1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
              child: Center(
                child: Text(
                  product.description,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
