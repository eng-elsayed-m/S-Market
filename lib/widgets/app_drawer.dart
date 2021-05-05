import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  final _buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
      overlayColor: MaterialStateProperty.all(Color(0xFFfb743e)),
      foregroundColor: MaterialStateProperty.all(Colors.white70),
      minimumSize: MaterialStateProperty.all(Size(double.infinity, 30)),
      textStyle: MaterialStateProperty.all(
        TextStyle(fontSize: 30, fontFamily: "Anton", letterSpacing: 2),
      ));
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          color: Theme.of(context).primaryColor,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/s_market.png",
                      height: 100,
                    ),
                    Flexible(
                      child: Text(
                        "S-Market",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontSize: 27, letterSpacing: 4),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.red,
              ),
              TextButton(
                child: Row(
                  children: [
                    Icon(Icons.home,
                        size: 45, color: Theme.of(context).accentColor),
                    SizedBox(width: 30),
                    Text("Home", style: Theme.of(context).textTheme.headline2),
                  ],
                ),
                onPressed: () => Navigator.of(context).popAndPushNamed("/"),
                style: _buttonStyle,
              ),
              TextButton(
                child: Row(
                  children: [
                    Icon(Icons.assignment_turned_in,
                        size: 45, color: Theme.of(context).accentColor),
                    SizedBox(width: 30),
                    Text("Orders",
                        style: Theme.of(context).textTheme.headline2),
                  ],
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(OrderScreen.nav),
                style: _buttonStyle,
              ),
              TextButton(
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome_motion,
                        size: 45, color: Theme.of(context).accentColor),
                    SizedBox(width: 30),
                    Text("My Products",
                        style: Theme.of(context).textTheme.headline2),
                  ],
                ),
                onPressed: () => Navigator.of(context)
                    .popAndPushNamed(UserProductsScreen.nav),
                style: _buttonStyle,
              ),
              Spacer(),
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.logout,
                    size: 44,
                    color: Color(0xFFdddddd),
                  ),
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false).logout();
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
