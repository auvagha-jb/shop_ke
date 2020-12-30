import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/ui/shared/notifications/app_flushbar.dart';
import 'package:shop_ke/ui/widgets/cart/undo_delete_button.dart';

/*
 * This class:
 * * Manages adding and removing of items from the cart
 * * Manages the items in the cart
 * * Manages the bill total
 */
class Cart with ChangeNotifier {
  double productsTotal = 0;

  //double _totalSummed;
  int _noItems = 0;
  List<Product> _products = [];

  List<Product> get productsList => [..._products];

//  final SnackbarService _snackbarService = locator<SnackbarService>();

  //Fail safe to prevent negative number of items
  set noItems(int no) => _noItems = no > -1 ? no : 0;

  //setTotalSummed() {
  //double sum = 0;
  //print('Sum: ${(_products.map((product) => sum += product.subtotal).toString())}');
  //}

  int get noItems => _noItems;

  void incrementNoItems() {
    noItems++;
    notifyListeners();
  }

  void incrementNoItemsBy(int productQuantity) {
    noItems += productQuantity;
    notifyListeners();
  }

  void decrementNoItems() {
    noItems--;
    notifyListeners();
  }

  ///Invoked on dismiss - since a number of items may be cleared at once
  void decrementNoItemsBy(int quantity) {
    noItems -= quantity;
    notifyListeners();
  }

  void decreaseProductsTotal(double amount) {
    productsTotal -= amount;
    //setTotalSummed();
    notifyListeners();
  }

  void increaseProductsTotal(double amount) {
    productsTotal += amount;
    //setTotalSummed();
    notifyListeners();
  }

  //Optional parameter is for adding parameter to a specific index after an undo operation
  void addProduct(BuildContext context, Product product, {int index = 0}) {
    print('Length of shopping list: ${productsList.length}');

    //If the shopping list has at least one item, check if the product exists
    final existingProductAndIndex =
        getProductIfExists(product.productId, productsList.length);

    //Action to take if item exists
    if (existingProductAndIndex != null) {
      print('Updating existing product');
      updateExistingProduct(existingProductAndIndex);
      return;
    }

    //Action to take if item does not exist
    print('Adding new product');
    //Sets the quantity of the product, by default sets to 1
    //for items that are restored, it is set to the quantity before it was deleted
    product.incrementQuantityAndSubtotalForNewProduct(product.quantity);

    //increase products total by its subtotal i.e. price x quantity
    increaseProductsTotal(product.price * product.quantity);

    //This takes care of when we are adding more than one item
    //Such as when we are undoing a delete
    incrementNoItemsBy(product.quantity);

    //Add the new item to the list
    _products.insert(index, product);

    //Show flushbar to confirm item has been added
    AppFlushbar.show(
      context,
      title: 'Item added',
      message: '${product.productName} added to cart',
      icon: Icon(Icons.add_shopping_cart),
    );

    notifyListeners();
  }

  void updateExistingProduct(Map<String, dynamic> existingProductAndIndex) {
    final product = existingProductAndIndex['product'];
    final index = existingProductAndIndex['index'];

    //Product Actions
    //Update the quantity, along with its subtotal and total price
    product.incrementQuantityAndSubtotal();

    //Cart Actions
    increaseProductsTotal(product.price);
    incrementNoItems();
    //Move the items to the top of the list
    moveToTop(index, product);
    notifyListeners();
  }

  //If product exists, it returns the product and its index. Else returns null
  dynamic getProductIfExists(String id, int shoppingListItems) {
    try {
      final int index = shoppingListItems > 0
          ? productsList.indexWhere((prod) => prod.productId == id)
          : null;

      return {
        'index': index,
        'product': productsList[index],
      };
    } catch (e) {
      return null;
    }
  }

  void deleteProduct(BuildContext context, int index, Product product) {
    _products.removeAt(index);
    decrementNoItemsBy(product.quantity);
    decreaseProductsTotal(product.subtotal);

    //Show the undo flushbar
    AppFlushbar.show(
      context,
      mainButton: UndoDeleteButton(index: index, product: product),
      title: 'Item Deleted',
      message: '${product.productName} deleted',
      icon: Icon(Icons.restore_from_trash),
    );

    notifyListeners();
  }

  void undoDelete(BuildContext context, {int index, Product product}) {
    //Return it to the top of the list
    addProduct(context, product, index: 0);
    notifyListeners();
  }

  void moveToTop(int currentIndex, Product product) {
    _products.removeAt(currentIndex);
    _products.insert(0, product);
  }
}
