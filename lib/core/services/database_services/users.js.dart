import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ke/core/models/data_models/customer.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/database_services/api_service.dart';
import 'package:http/http.dart';

class Users extends ApiService {
  Future<ServiceResponse> insertUser(Customer customer, User user) async {
    final endpoint = route("user/");
    customer.firebaseId = user.uid;
    ServiceResponse serviceResponse =
        await super.insert(endpoint: endpoint, map: customer.toMap());

    if (!serviceResponse.status) {
      user.delete();
    }

    return serviceResponse;
  }

  Future<ServiceResponse> testInsert(Customer customer) async {
    ServiceResponse serviceResponse;
    try {
      final endpoint = route("user/");

      print(customer.toMap());

      Response response = await client.post(
        endpoint,
        headers: jsonHeaders,
        body: jsonEncode(customer.toMap()),
      );

      serviceResponse = ServiceResponse.fromJson(response.body);

      if (!serviceResponse.status) {
        throw new Exception(serviceResponse.response);
      }
    } catch (e) {
      print(e);
    }
    return serviceResponse;
  }

  Future<Customer> getUserById(String id) async {
    final endpoint = route("user/$id");
    List customers = await super.get(endpoint);
    Customer customer;

    if (customers.length > 0) {
      customer = Customer.fromMap(customers.first);
    }

    return customer;
  }

  Future<Customer> getUserByFirebaseId(String id) async {
    final endpoint = route("user/firebase/$id");
    final List customers = await super.get(endpoint);
    Customer customer;

    if (customers.length > 0) {
      customer = Customer.fromMap(customers.first);
    }

    return customer;
  }
}
