import 'package:flutter/cupertino.dart';

class ServiceResponse {
  bool status;
  dynamic response;

  ServiceResponse({@required this.status, @required this.response}){
    print('serviceResponse: ${toMap()}');
  }

  ServiceResponse.fromJson(Map<String, dynamic> map) {
    print('Service response: $map');
    status = map['status'];
    response = map['response'];
  }

  Map<String, dynamic> toMap() {
    return {'response': response, 'status': status};
  }
}
