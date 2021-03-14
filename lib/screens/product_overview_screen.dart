import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/add_product_screen.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
// enum Filter { ShowFavorite, ShowAll }

class ProductOverviewScreen extends StatefulWidget {
  static const nav = "/product-overview";

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        primary: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton(
          
          child: Icon(
            Icons.add,
            size: 50,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () =>
              Navigator.of(context).pushNamed(AddProductScreen.nav),
              tooltip: "Add new product",
        ),
        drawer: AppDrawer(),
        backgroundColor: Theme.of(context).primaryColor.withAlpha(750),
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: Theme.of(context).accentColor, size: 60.0),
          title: Text(
            _showFavOnly ? "Favorite" : "Shop",
            style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 40),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  _showFavOnly = !_showFavOnly;
                });
              },
              child: Icon(
                _showFavOnly ? Icons.favorite : Icons.favorite_border_outlined,
                color: Colors.red[900],
                size: 40,
              ),
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
                empty: cart.items.isEmpty,
              ),
              child: InkWell(
                onTap: () => Navigator.of(context).pushNamed(CartScreen.nav),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(child: ProductsGrid(_showFavOnly)));
  }
}
