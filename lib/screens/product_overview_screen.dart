import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import 'package:rolling_nav_bar/rolling_nav_bar.dart';

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
      drawer: AppDrawer(),
        backgroundColor: Theme.of(context).primaryColor.withAlpha(750),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).accentColor,size: 60.0),
          title: Text(
            _showFavOnly ? "Favorite":
            "Shop",
            style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 40),
          ),
          actions: <Widget>[
            Consumer<Cart>(
              builder: (_,cart,ch)=>  Badge(
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
        bottomNavigationBar: Container(
          height: 55,
          child: RollingNavBar.iconData(
            navBarDecoration: BoxDecoration(
              // color: Theme.of(context).accentColor,
              gradient: LinearGradient(
                colors: [Theme.of(context).primaryColor,Theme.of(context).accentColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
                ),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
              ),
            iconSize: 30,
            activeIconColors: [Theme.of(context).accentColor,Colors.red[900],],
            indicatorColors: [Theme.of(context).primaryColor],
            animationCurve:
                Curves.easeOut, // `easeOut` (the default) is recommended here
            animationType: AnimationType.roll,
            baseAnimationSpeed: 500, // milliseconds
            iconColors: <Color>[
              Colors.white60
            ],
            iconData: <IconData>[
              Icons.shopping_basket,
              Icons.favorite,
            ],
            onTap: (index) => {
              setState(() {
                if (index == 0) {
                  _showFavOnly = false;
                } else {
                  _showFavOnly = true;
                }
              })
            },
          ),
        ),
        body: SafeArea(child: ProductsGrid(_showFavOnly)));
  }
}
