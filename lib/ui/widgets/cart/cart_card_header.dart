import 'package:flutter/material.dart';
import 'package:shop_ke/ui/shared/utils/text_styles.dart';

class CartCardHeader extends StatelessWidget {
  final String title;

  const CartCardHeader({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(title, style: darkHeader2),
            ),
          ],
        ),
        Divider(color: Colors.grey),
      ],
    );
  }
}
