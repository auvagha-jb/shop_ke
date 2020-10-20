import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String brand;
  final double price;
  int quantity;
  double subtotal;
  final String imageUrl;

  Product({
    this.id,
    this.name,
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

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
      id: parsedJson['id'] as String,
      name: parsedJson['name'] as String,
      brand: parsedJson['brand'] as String,
      price: parsedJson['price'] as double,
      imageUrl: parsedJson['imageUrl'] as String,
    );
  }
}
