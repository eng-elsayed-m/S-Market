import 'package:flutter/material.dart';
import '../widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  static const navName = "/auth";
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return  SingleChildScrollView(
        
        child: Container(
          color: Colors.white,
          constraints: BoxConstraints(maxHeight: deviceSize.height,),
          width: deviceSize.width,
          height: deviceSize.height,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(bottom: 20, top: 80),
                  margin: EdgeInsets.all(15),
                  child: Text(
                    "Store",
                    style: Theme.of(context).textTheme.headline1.copyWith(shadows: [Shadow(color: Theme.of(context).accentColor,blurRadius: 2,offset: Offset(-4,0))]),
                  ),
                ),
              ),
              Flexible(
                child: AuthForm(),
              )
            ],
          ),
        ),
      );
  }
}
