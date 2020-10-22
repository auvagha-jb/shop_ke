import 'package:flutter/cupertino.dart';

class ServiceResponse {
  bool status;
  dynamic response;

  ServiceResponse({@required this.status, @required this.response}){
    print('Service response: $response');
  }
}
