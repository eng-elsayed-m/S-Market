import 'package:flutter/material.dart';
import '../widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  static const navName = "/auth";
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColor,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.center,
              stops: [0.5, 0.1])),
      constraints: BoxConstraints(
        maxHeight: deviceSize.height,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthForm(),
          Container(
              padding: EdgeInsets.only(bottom: 12, top: 46),
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/s_market.png",
                    height: 100,
                  ),
                  Text(
                    "Smart Market",
                    style: Theme.of(context).textTheme.headline4,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
