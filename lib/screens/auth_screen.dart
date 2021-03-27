import 'package:flutter/material.dart';
import '../widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  static const navName = "/auth";
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return  Container(
      color: Theme.of(context).primaryColor,
      constraints: BoxConstraints(maxHeight: deviceSize.height,),
      width: deviceSize.width,
      height: deviceSize.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.only(bottom: 12, top: 46),
              margin: EdgeInsets.all(15),
              child:Icon(Icons.shopping_bag,size: 80,color: Theme.of(context).accentColor,)
            ),
          ),
          Flexible(
            flex: 2,
            child: AuthForm(),
          )
        ],
      ),
    );
  }
}
