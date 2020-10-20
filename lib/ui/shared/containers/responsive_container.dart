import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final AppBar appBar;
  final double height;
  final BoxDecoration decoration;

  ResponsiveContainer({
    @required this.child,
    @required this.height,
    this.appBar,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final viewPortHeight = MediaQuery
        .of(context)
        .size
        .height;
    final appBarHeight = appBar != null ? appBar.preferredSize.height : 0;
    final topPadding = MediaQuery
        .of(context)
        .padding
        .top;

    return Container(
      height: (viewPortHeight - appBarHeight - topPadding) * height,
      child: child,
      decoration: decoration,
    );
  }
}
