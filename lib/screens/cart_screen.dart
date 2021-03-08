import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/widgets/cart_body.dart';

class CartScreen extends StatelessWidget {
  static const nav = "/cart";
  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<Cart>(
          builder: (ctx, cart, _) => cart.items.isEmpty
              ? Center(
                  child: Text(
                  "Your Card is Empty",
                  style: Theme.of(context).textTheme.headline4,
                ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      color: Theme.of(context).accentColor,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total :",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Chip(
                              backgroundColor: Theme.of(context).primaryColor,
                              label: Text(
                                "\$${cart.totalAmount.toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                cart.itemCount.toString() + " Items",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            InkWell(
                              child: Text(
                                "Order Now",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              onTap: () {
                                Provider.of<Orders>(context, listen: false)
                                    .addOrder(cart.items.values.toList(),
                                        cart.totalAmount);
                                cart.clear();
                                Navigator.of(context)
                                    .pushReplacementNamed(OrderScreen.nav);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (BuildContext context, int i) {
                          return CartBody(
                            cart: cart.items.values.toList()[i],
                            cartId: cart.items.keys.toList()[i],
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
