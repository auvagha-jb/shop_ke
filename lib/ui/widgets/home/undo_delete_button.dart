import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:shop_ke/core/models/data_models/product.dart';

class UndoDeleteButton extends StatefulWidget {
  final int index;
  final Product product;

  const UndoDeleteButton(
      {Key key, @required this.index, @required this.product})
      : assert(index != null),
        assert(product != null),
        super(key: key);

  @override
  _UndoDeleteButtonState createState() => _UndoDeleteButtonState();
}

class _UndoDeleteButtonState extends State<UndoDeleteButton> {
  bool isClicked = false;

  void disableButton() {
    isClicked = true;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return FlatButton(
      onPressed: isClicked == false
          ? () {
              cart.undoDelete(widget.index, widget.product);
              disableButton(); //Disable button onPressed to prevent undo action more than once
            }
          : null,
      child: Text(
        'UNDO',
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
    );
  }
}
