import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';

class OrderBody extends StatefulWidget {
  final OrderItem order;
  final String id;
  const OrderBody({@required this.order, @required this.id});

  @override
  _OrderBodyState createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () async {
        try {
          await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text("Are you sure ?"),
                    content: Text("You wanna delete this order"),
                    actions: [
                      TextButton(
                        child: Text("Sure"),
                        onPressed: () async {
                          Navigator.of(ctx).pop();

                          await Provider.of<Orders>(context, listen: false)
                              .removeItem(widget.order.id)
                              .catchError((e) {
                            print(e);
                          });
                        },
                      ),
                      TextButton(
                        child: Text("No"),
                        onPressed: () => Navigator.of(ctx).pop(),
                      )
                    ],
                  ));
        } catch (e) {
          print(e);
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: _expanded
            ? min(widget.order.products.length * 20.0 + 110, 200)
            : 95,
        child: Card(
          color: Color(0xFF30475e),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Order value : \$${widget.order.amount.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Text(
                  DateFormat("dd / MM / yyyy a hh:mm")
                      .format(widget.order.dateTime),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
                trailing: IconButton(
                  icon: Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: Theme.of(context).accentColor,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: _expanded
                    ? min(widget.order.products.length * 20.0 + 10, 100)
                    : 0,
                child: ListView(
                  children: widget.order.products
                      .map((item) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.title,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text(
                                "\$${item.price}${item.quantity}x",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(fontSize: 18),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
