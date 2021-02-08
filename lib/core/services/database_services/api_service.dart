import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shop_ke/core/models/app_models/service_response.dart';

/// The service responsible for networking requests
class ApiService {
//  String _remoteHost;
  String _localhost;
  String _baseUrl;
  final Client _client = new http.Client();
  final _timeoutDuration = Duration(seconds: 60);

  Client get client => _client;

  ApiService() {
//    _remoteHost = 'http://johngachihi.com/shop_ke/';
    _localhost = 'http://10.0.2.2:6000/';
    _baseUrl = _localhost;
  }

  Map<String, String> _jsonHeaders = {
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
      print('POST Request');

      Response response = await _client
          .post(
            endpoint,
            headers: _jsonHeaders,
            body: jsonEncode(map),
          )
          .timeout(_timeoutDuration);

      print('ApiService.post() ${response.body}');

      serviceResponse = ServiceResponse.fromJson(response.body);

      if (!serviceResponse.status) {
        print('Insert error: ${serviceResponse.response}');
        throw new Exception('Something went wrong wth the post request');
      }

      print('Map to be inserted: $map');
    } catch (e) {
      print('[ApiService.insert()] $e');
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
      print('GET request');

      final Response response = await _client.get(endpoint).timeout(_timeoutDuration);

      //Converts the json response to an map
      final ServiceResponse serviceResponse = ServiceResponse.fromJson(response.body);

      if (!serviceResponse.status) {
        return [];
      }

      resultSet = serviceResponse.response;
    } catch (e) {
      print('[_get] $e');

      if (e is TimeoutException) {
        throw ('Server timed out. Check your internet connection and try again');
      }
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
