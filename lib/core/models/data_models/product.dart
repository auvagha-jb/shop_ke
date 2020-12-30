import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String productId;
  final String storeId;
  final String productName;
  final String description;
  final double price;
  final String imageUrl;

//  String numInStock; --> Future works

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
    return Product(
      productId: map['productId'],
      storeId: map['storeId'],
      productName: map['productName'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'storeId': storeId,
      'productName': productName,
      'description': description,
      'price': price,
      'imageUrl': imageUrl
    };
  }

}
