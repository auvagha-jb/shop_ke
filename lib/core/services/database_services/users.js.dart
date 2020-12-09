import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ke/core/models/data_models/customer.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/database_services/api_service.dart';
import 'package:http/http.dart';

class Users extends ApiService {
  Future<ServiceResponse> insert(Customer customer, User user) async {
    ServiceResponse serviceResponse;
    try {
      final endpoint = route("user/");

      customer.firebaseId = user.uid;
      print(customer.toMap());

      Response response = await client.post(
        endpoint,
        headers: jsonHeaders,
        body: jsonEncode(customer.toMap()),
      );

      serviceResponse = ServiceResponse.fromJson(json.decode(response.body));

      if (!serviceResponse.status) {
        throw new Exception(serviceResponse.response);
      }
    } catch (e) {
      user.delete();
    }
    return serviceResponse;
  }

  Future<Customer> getUserById(int id) async {
    final endpoint = route("user/$id");
    final Response response = await client.get(endpoint);
    final ServiceResponse serviceResponse =
        ServiceResponse.fromJson(json.decode(response.body));
    Customer customer;

    if (serviceResponse.status) {
      var customerMap = serviceResponse.response.first;
      print(customerMap);
      customer = Customer.fromMap(customerMap);
    }
    return customer;
  }

  Future<Customer> getUserByFirebaseId(String id) async {
    final endpoint = route("user/firebase/$id");
    final Response response = await client.get(endpoint);
    final ServiceResponse serviceResponse =
        ServiceResponse.fromJson(json.decode(response.body));
    Customer customer;

    if (serviceResponse.status) {
      var customerMap = serviceResponse.response.first;
      print(customerMap);
      customer = Customer.fromMap(customerMap);
    }
    return customer;
  }
}
