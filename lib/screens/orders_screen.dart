import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/order_body.dart';

class OrderScreen extends StatelessWidget {
  static const nav = "/order";

//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   @override
//   void initState() {
//     Future.delayed(Duration.zero).then(
//         (value) => Provider.of<Orders>(context, listen: false).fetchOrders());
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<Orders>(context).orders;

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
            title: Text("My orders",
                style: Theme.of(context).textTheme.headline2)),
        body: FutureBuilder(
            future: Provider.of<Orders>(context, listen: false).fetchOrders(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (dataSnapshot.hasError) {
                return Text("An error occurred !");
              } else {
                return Consumer<Orders>(builder: (ctx, ordersData, _) {
                  return ordersData.orders.isEmpty
                      ? Center(
                          child: Text("No Orders",
                              style: Theme.of(context).textTheme.headline4),
                        )
                      : ListView.builder(
                          itemCount: ordersData.orders.length,
                          itemBuilder: (BuildContext context, int index) {
                            return OrderBody(
                                order: ordersData.orders[index],
                                id: ordersData.orders[index].id);
                          },
                        );
                });
              }
            }));
  }
}
