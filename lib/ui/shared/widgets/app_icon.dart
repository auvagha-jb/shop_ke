import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/icon_type.dart';

class AppIcon extends StatelessWidget {
  final IconType iconType;
  final double iconSize;
  final Icon icon;

  const AppIcon({
    Key key,
    @required this.iconType,
    this.iconSize,
    this.icon,
  })  : assert(iconType != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = getIconColor(context, iconType);

    return Center(
      child: IconButton(
        //Default icon == shopping cart, else the icon specified is chosen
        icon: icon == null ? Icon(Icons.add_shopping_cart) : icon,
        onPressed: () {},
        iconSize: iconSize == null ? 85 : iconSize,
        color: color,
      ),
    );
  }

  Color getIconColor(BuildContext context, IconType iconType) {
    Color color;

    switch (iconType) {
      case IconType.Primary:
        color = Theme.of(context).primaryColor;
        break;
      case IconType.Light:
        color = Theme.of(context).canvasColor;
        break;
      case IconType.Accent:
        color = Theme.of(context).accentColor;
        break;
      case IconType.Secondary:
        color = Theme.of(context).backgroundColor;
        break;
    }
    return color;
  }
}
