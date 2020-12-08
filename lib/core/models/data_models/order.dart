import 'package:shop_ke/core/models/data_models/product.dart';

class Order {
  String id;
  String userId;
  String storeId;
  String orderTimestamp;
  bool orderStatus;
  List<String> productIds;
  List<Product> orderItems;

  Order.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userId = map['userId'];
    storeId = map['storeId'];
    orderTimestamp = map['orderTimestamp'];
    orderStatus = map['orderStatus'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'storeId': storeId,
      'orderTimestamp': orderTimestamp,
      'orderStatus': orderStatus,
      'orderItems': '',
    };
  }
}
