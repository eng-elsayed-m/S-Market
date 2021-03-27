import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
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
  // bool _init = true;
  // bool _loading = false;
  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   if (_init) {
  //     setState(() {
  //       _loading = true;
  //     });
  //     Provider.of<Products>(context, listen: false)
  //         .fetchProducts()
  //         .then((value) {
  //       setState(() {
  //         _loading = false;
  //       });
  //     });
  //     _init = false;
  //   }
  //   super.didChangeDependencies();
  // }

  Future<void> _refreshProducts() async {
    await Provider.of<Products>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        primary: true,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
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
                  color: Color(0xFF30475e),
                  size: 40,
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder(
            future:
                Provider.of<Products>(context, listen: false).fetchProducts(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (dataSnapshot.error != null) {
                return Center(child: Text("an error occurred !",style: Theme.of(context).textTheme.headline3,));
              } else {
                return RefreshIndicator(
                  child: ProductsGrid(_showFavOnly),
                  onRefresh: () => _refreshProducts(),
                );
              }
            }));
  }
}
