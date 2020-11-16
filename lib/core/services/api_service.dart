import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shop_ke/core/models/comment.dart';
import 'package:shop_ke/core/models/post.dart';
import 'package:shop_ke/core/models/ticket.dart';

/// The service responsible for networking requests
class ApiService {
  static const endpoint = 'https://jsonplaceholder.typicode.com';
  static const localhost = 'http://10.0.2.2';
  var client = new http.Client();

  Future<Ticket> getTicket(String phoneNumber) async {
    final endpoint = "$localhost:8100/ticket/$phoneNumber";
    print(endpoint);
    final Response response = await client.get(endpoint);

    return Ticket.fromMap(json.decode(response.body));
  }

  Future<List<Post>> getPostsForUser(int userId) async {
    var posts = List<Post>();
    // Get user posts for id
    var response = await client.get('$endpoint/posts?userId=$userId');

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
    var response = await client.get('$endpoint/comments?postId=$postId');

    // Parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // Loop and convert each item to a Comment
    for (var comment in parsed) {
      comments.add(Comment.fromJson(comment));
    }

    return comments;
  }
}
