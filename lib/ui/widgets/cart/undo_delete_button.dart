import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/app_models/cart.dart';
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
      onPressed: !isClicked
          //Choose action based on whether the button had been clicked or not
          ? () {
              //If undo had not been clicked already, add the product to the top of the cart
              cart.undoDelete(
                context,
                index: widget.index,
                product: widget.product,
              );

              //Disable button onPressed to prevent undo action more than once
              disableButton();
            }
      //After click, do nothing
          : null,
      child: Text(
        'UNDO',
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
    );
  }
}
