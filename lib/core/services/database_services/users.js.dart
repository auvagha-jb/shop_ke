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

      serviceResponse = ServiceResponse.fromJson(response.body);

      if (!serviceResponse.status) {
        throw new Exception(serviceResponse.response);
      }
    } catch (e) {
      user.delete();
      print('Insert error $e');
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
    final Response response = await client.get(endpoint);
    final ServiceResponse serviceResponse =
        ServiceResponse.fromJson(response.body);
    Customer customer;

    if (!serviceResponse.status) {
      return null;
    }

    if(serviceResponse.response.length > 0) {
      var customerMap = serviceResponse.response.first;
      customer = Customer.fromMap(customerMap);
    }

    return customer;
  }

  Future<Customer> getUserByFirebaseId(String id) async {
    final endpoint = route("user/firebase/$id");
    final Response response = await client.get(endpoint);
    final ServiceResponse serviceResponse =
        ServiceResponse.fromJson(response.body);
    Customer customer;

    if (!serviceResponse.status) {
      return null;
    }

    if(serviceResponse.response.length > 0) {
      Map<String, dynamic> customerMap = serviceResponse.response.first;
      customer = Customer.fromMap(customerMap);
    }

    return customer;
  }
}
