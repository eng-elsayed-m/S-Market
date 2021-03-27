import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartBody extends StatelessWidget {
  final CartItem cart;
  final String cartId;
  const CartBody({this.cart, this.cartId});
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Dismissible(
      key: ValueKey(cartId),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.all(10),
        color: _theme.accentColor,
        child: Icon(
          Icons.delete,
          color: _theme.primaryColor,
          size: 40,
        ),
        alignment: Alignment.centerRight,
      ),
      child: Card(
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _theme.accentColor,
              child: Text(
                "${cart.quantity}x",
                style: _theme.textTheme.headline3 ,
              ),
            ),
            title: Text(
              cart.title,
              style: _theme.textTheme.headline4,
            ),
            subtitle: Text(
              "\$" + cart.price.toStringAsFixed(2),
              style: _theme.textTheme.headline5,
            ),
            trailing: Chip(
              backgroundColor: _theme.accentColor,
              label: Text(
                "\$" + (cart.price * cart.quantity).toStringAsFixed(2),
                style: _theme.textTheme.headline3,
              ),
            ),
          )),
      onDismissed: (dir) =>
          Provider.of<Cart>(context, listen: false).removeItem(cartId),
      confirmDismiss: (direc) {
        return showDialog(
            context: context,
            builder: (builder) => AlertDialog(
                  title: Text("Are You Sure ? "),
                  content: Text(" You wanna delete this item from card ?"),
                  actions: [
                    TextButton(
                      child: Text("Yes"),
                      onPressed: () => Navigator.of(builder).pop(true),
                    ),
                    TextButton(
                      child: Text("No"),
                      onPressed: () => Navigator.of(builder).pop(false),
                    ),
                  ],
                ));
      },
    );
  }
}
