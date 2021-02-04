import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String productId;
  String storeId;
  String productName;
  String description;
  double _price; //Avoided an explicit type to avoid int and double conversion problems
  String _imageUrl;
  int numInStock;

  //When placing the order
  int quantity = 0;
  double subtotal = 0;

  Product();

  set price(var value) {
    switch (value.runtimeType) {
      case int:
        int price = value;
        _price = price.toDouble();
        break;

      case String:
        _price = double.parse(value);
        break;

      default:
        _price = value;
    }
  }

  double get price => _price;

  String get imageUrl => _imageUrl ?? 'http://dummyimage.com/250x250.jpg/2e7d32/ffffff';

  set imageUrl(String value) => _imageUrl = imageUrl;

  void incrementQuantityAndSubtotalForNewProduct(int productQuantity) {
    quantity = productQuantity > 0 ? productQuantity : 1; //Set the quantity to one if the quantity was zero
    subtotal = quantity * price;
    notifyListeners();
  }

  void incrementQuantityAndSubtotal() {
    quantity++;
    subtotal = quantity * price;
    notifyListeners();
  }

  void decrementQuantityAndSubtotal() {
    quantity--;
    subtotal = quantity * price;
    notifyListeners();
  }

  Product.fromMap(Map<String, dynamic> map) {
    print('Product.fromMap $map');
    productId = map['productId'];
    storeId = map['storeId'];
    productName = map['productName'];
    description = map['description'];
    price = map['price'];
    imageUrl = map['imageUrl'];
    numInStock = map['numInStock'];
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'storeId': storeId,
      'productName': productName,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'numInStock': numInStock
    };
  }
}
