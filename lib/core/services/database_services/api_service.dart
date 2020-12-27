import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shop_ke/core/models/comment.dart';
import 'package:shop_ke/core/models/post.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/models/ticket.dart';

/// The service responsible for networking requests
class ApiService {
  String _remoteHost;
  String _localhost;
  String _baseUrl;
  final Client _client = new http.Client();

  Client get client => _client;

  ApiService() {
    _remoteHost = 'http://johngachihi.com/shop_ke/';
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

  Future<Response> post({
    @required String endpoint,
    @required Map<String, dynamic> map,
  }) async {
    Response response = await client.post(
      endpoint,
      headers: jsonHeaders,
      body: jsonEncode(map),
    );
    return response;
  }

  Future<ServiceResponse> insert({
    @required endpoint,
    @required Map<String, dynamic> map,
  }) async {
    ServiceResponse serviceResponse;

    try {
      Response response = await this.post(endpoint: endpoint, map: map);
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

  Future<List<dynamic>> get(String endpoint) async {
    final Response response = await client.get(endpoint);
    final ServiceResponse serviceResponse =
        ServiceResponse.fromJson(response.body);
    var resultSet = [];

    if (!serviceResponse.status) {
      return null;
    }

    if (serviceResponse.response.length > 0) {
      resultSet = serviceResponse.response;
    }

    return resultSet;
  }

  Future<Ticket> getTicket(String phoneNumber) async {
    final endpoint = route("ticket/$phoneNumber");
    final Response response = await client.get(endpoint);
    return Ticket.fromMap(json.decode(response.body));
  }

  Future<List<Post>> getPostsForUser(int userId) async {
    var posts = List<Post>();
    // Get user posts for id
    var response = await client.get('$_remoteHost/posts?userId=$userId');

    // parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // loop and convert each item to Post
    for (var post in parsed) {
      posts.add(Post.fromJson(post));
    }

    return posts;
  }

  Future<List<Comment>> getCommentsForPost(int postId) async {
    var comments = List<Comment>();

    // Get comments for post
    var response = await client.get('$_remoteHost/comments?postId=$postId');

    // Parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // Loop and convert each item to a Comment
    for (var comment in parsed) {
      comments.add(Comment.fromJson(comment));
    }

    return comments;
  }
}
