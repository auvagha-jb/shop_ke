import 'package:shop_ke/core/models/data_models/product.dart';

class OrderItem {
  Map<String, dynamic> _productToOrderItem(Product product) {
    return {
      "productId": product.productId,
      "storeId": product.storeId,
      "price": product.price,
      "quantity": product.quantity,
      "subtotal": product.subtotal
    };
  }

  List<Map<String, dynamic>> orderItemsList(List<Product> products) {
    List<Map<String, dynamic>> orderItems = [];
    //Convert the List<Product> to List<Map> containing orderItems
    for (Product product in products) {
      var orderItem = _productToOrderItem(product);
      orderItems.add(orderItem);
    }

    return orderItems;
  }
}
