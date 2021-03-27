import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge({
    @required this.child,
    @required this.value,
    this.color,
    this.empty,
  });

  final Widget child;
  final String value;
  final Color color;
  final bool empty;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: child,
        ),
        empty? Container() :
        Positioned(
          right: 2,
          top: 4,
          child: Container(
            padding: EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color != null ? color : Theme.of(context).accentColor,
            ),
            constraints: BoxConstraints(
              minWidth: 18,
              minHeight: 18,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white
              ),
            ),
          ),
        )
      ],
    );
  }
}
