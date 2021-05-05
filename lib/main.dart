import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/add_product_screen.dart';
import 'providers/orders.dart';
import 'providers/products.dart';
import 'providers/cart.dart';
import 'screens/cart_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/user_products_screen.dart';
import 'providers/auth.dart';
import 'screens/product_overview_screen.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(Store());
}

class Store extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) =>
              Products(auth.token, auth.userId),
          create: null,
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousProducts) =>
              Orders(auth.token, auth.userId),
          create: null,
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ShopApp',
          theme: ThemeData(
              fontFamily: "Lato ",
              primaryColor: Color(0xFF222831),
              accentColor: Color(0xFFf05454),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: TextTheme(
                headline1: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Anton",
                  letterSpacing: 7,
                  fontSize: 50,
                  color: Color(0xFFdddddd),
                ),
                headline2: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFdddddd),
                    fontFamily: "Lato",
                    fontSize: 30),
                headline3: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Color(0xFF30475e),
                ),
                headline4: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Color(0xFFdddddd),
                ),
                headline5: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Color(0xFFf05454),
                ),
              )),
          home: auth.isAuth
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (ctx, AsyncSnapshot snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? CircularProgressIndicator()
                          : AuthScreen()),
          routes: {
            ProductDetailScreen.nav: (ctx) => ProductDetailScreen(),
            AddProductScreen.nav: (ctx) => AddProductScreen(),
            OrderScreen.nav: (ctx) => OrderScreen(),
            CartScreen.nav: (ctx) => CartScreen(),
            UserProductsScreen.nav: (ctx) => UserProductsScreen(),
            EditProductScreen.nav: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
