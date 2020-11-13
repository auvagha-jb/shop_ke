import 'package:flutter/material.dart';

class Subscription {
  final String userId;
  final String storeId;

  Subscription({@required this.userId, @required this.storeId});

  Map<String, String> toMap() {
    return {'userId': userId, 'storeId': storeId};
  }
}
