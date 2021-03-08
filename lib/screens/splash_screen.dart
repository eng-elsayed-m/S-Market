import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
    static const nav = "/splash";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}