import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/order_body.dart';

class OrderScreen extends StatelessWidget {
  static const nav = "/order";
  @override
  Widget build(BuildContext context) {
    final  ordersData = Provider.of<Orders>(context).orders;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: 
      AppBar(title: Text("My orders")),
      body: SafeArea(
        child: ordersData.isEmpty ? Center(child: Text("No Orders"),):
        ListView.builder(
          itemCount: ordersData.length,
          itemBuilder: (BuildContext context, int index) {
          return OrderBody(order: ordersData[index]);
         },
        ),
      ),);
  }
}
