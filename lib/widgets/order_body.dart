import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart';

class OrderBody extends StatefulWidget {
  final OrderItem order;

  const OrderBody({@required this.order});

  @override
  _OrderBodyState createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
          ListTile(
            tileColor: Theme.of(context).accentColor,
            title: Text(
                "Order value : \$${widget.order.amount.toStringAsFixed(2)}",style: Theme.of(context).textTheme.headline4,),
            subtitle: Text(
              DateFormat("dd / MM / yyyy a hh:mm")
                  .format(widget.order.dateTime),
                  style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more,color: Theme.of(context).primaryColor,size: 40,),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if(_expanded)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: min(widget.order.products.length * 20.0 + 10, 100),
            child: ListView(children: widget.order.products.map((item) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.title,style: Theme.of(context).textTheme.headline3,),
                Text("${item.quantity}x \$${item.price}",style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 18),),
              ],
            )).toList(),),
          ) ,
        ],
      ),
    );
  }
}
