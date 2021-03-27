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
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Card",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: SafeArea(
        child:cart.items.isEmpty?Center(child: Text("No Items in cart",style: Theme.of(context).textTheme.headline4,),): Column(
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
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        cart.itemCount.toString() + " Items",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    OrderBotton(cart: cart),
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
    );
  }
}

class OrderBotton extends StatefulWidget {
  const OrderBotton({@required this.cart});

  final Cart cart;

  @override
  _OrderBottonState createState() => _OrderBottonState();
}

class _OrderBottonState extends State<OrderBotton> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: _loading
          ? CircularProgressIndicator(
              backgroundColor: Colors.white,
            )
          : Text(
              "Order Now",
              style: Theme.of(context).textTheme.headline3,
            ),
      onTap: () async {
        setState(() {
          _loading = true;
        });
        await Provider.of<Orders>(context, listen: false).addOrder(
            widget.cart.items.values.toList(), widget.cart.totalAmount);
        widget.cart.clear();
        Navigator.of(context).pushReplacementNamed(OrderScreen.nav);
        setState(() {
          _loading = false;
        });
      },
    );
  }
}
