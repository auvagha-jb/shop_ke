import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String productName;
  final String brand;
  final double price;
  int quantity;
  double subtotal;
  final String imageUrl;

  Product({
    this.id,
    this.productName,
    this.brand,
    this.price,
    this.quantity = 1,
    this.subtotal = 0,
    this.imageUrl,
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
      id: map['id'] as String,
      productName: map['productName'] as String,
      brand: map['brand'] as String,
      price: map['price'] as double,
      imageUrl: map['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,

    };
  }

}
