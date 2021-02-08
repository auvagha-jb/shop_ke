import 'dart:convert';

import 'package:flutter/material.dart';

class ServiceResponse {
  bool status;
  dynamic response;
  String insertId;
  String log;

  ServiceResponse({@required this.status, @required this.response}) {
    print('serviceResponse: ${_toMap()}');
  }

  ServiceResponse.fromJson(String json) {
    try {
      Map<String, dynamic> map = jsonDecode(json);

      status = map['status'];
      response = map['response'];
      log = map['log'];

      if (map['insertId'] != null) {
        insertId = map['insertId'];
      }

//      print('serviceResponse: $map');
    } catch (e) {
      print('[ServiceResponse.fromJson] $e');
    }
  }

  Map<String, dynamic> _toMap() {
    return {'response': response, 'status': status};
  }
}
