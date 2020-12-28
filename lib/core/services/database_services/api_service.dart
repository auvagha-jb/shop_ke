import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shop_ke/core/models/service_response.dart';

/// The service responsible for networking requests
class ApiService {
//  String _remoteHost;
  String _localhost;
  String _baseUrl;
  final Client _client = new http.Client();

  ApiService() {
//    _remoteHost = 'http://johngachihi.com/shop_ke/';
    _localhost = 'http://10.0.2.2:6000/';
    _baseUrl = _localhost;
  }

  Map<String, String> jsonHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  String route(path) {
    String endpoint = '$_baseUrl' + path;
    print(endpoint);
    return endpoint;
  }

  Future<ServiceResponse> post({
    @required endpoint,
    @required Map<String, dynamic> map,
  }) async {
    ServiceResponse serviceResponse;

    try {
      Response response = await _client.post(
        endpoint,
        headers: jsonHeaders,
        body: jsonEncode(map),
      );

      serviceResponse = ServiceResponse.fromJson(response.body);

      if (!serviceResponse.status) {
        print('Insert error: ${serviceResponse.response}');
        throw new Exception('Something went wrong wth the insert');
      }
      print('Map to be inserted: $map');
    } catch (e) {
      print('[insert] $e');
      serviceResponse = ServiceResponse(status: false, response: e);
    }

    return serviceResponse;
  }

  ///Performs get requests
  ///@param String endpoint - the route
  ///@returns resultSet - array of result objects
  Future<List> _get(String endpoint) async {
    List resultSet = [];
    try {
      final Response response = await _client.get(endpoint);

      //Converts the json response to an object
      final ServiceResponse serviceResponse =
          ServiceResponse.fromJson(response.body);
      if (!serviceResponse.status) {
        return null;
      }

      resultSet = serviceResponse.response;
    } catch (e) {
      print('[_get] $e');
    }

    return resultSet;
  }

  Future<Map<String, dynamic>> getItem(String endpoint) async {
    List resultSet = await this._get(endpoint);
    if (resultSet.length < 1) {
      return null;
    }

    return resultSet.first;
  }

  Future<List> getList(String endpoint) async {
    List resultSet = await this._get(endpoint);
    return resultSet;
  }
}
