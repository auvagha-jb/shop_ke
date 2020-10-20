import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  final Widget child;

  const CardTile({Key key, @required this.child}) : assert(child != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.0), //(x,y)
            blurRadius: 2.0,
          ),
        ],
      ),
      //To add elevation
      child: child,
    );
  }
}
