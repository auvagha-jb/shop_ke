import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String productId;
  String storeId;
  String productName;
  String description;
  var price; //Avoided an explicit type to avoid int and double conversion problems
  String imageUrl;
  int numInStock;

  //When placing the order
  int quantity;
  double subtotal;

  Product({
    this.productId,
    this.storeId,
    this.productName,
    this.description,
    this.price,
    this.imageUrl,
    this.numInStock = 0,
    this.subtotal = 0,
    this.quantity = 1,
  });

  void incrementQuantityAndSubtotalForNewProduct(int productQuantity) {
    quantity = productQuantity;
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

  factory Product.fromMap(Map<String, dynamic> map) {
    print('Product.fromMap $map');
    return Product(
      productId: map['productId'],
      storeId: map['storeId'],
      productName: map['productName'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      numInStock: map['numInStock']
    );
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
