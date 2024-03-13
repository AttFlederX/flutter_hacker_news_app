import 'dart:convert';
import 'dart:io';

import 'package:hacker_news_app/models/comment/comment.dart';
import 'package:hacker_news_app/models/story/story.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _baseUrl = "https://hacker-news.firebaseio.com/v0";

  Future<List<int>> getFeedStoryIds() async {
    final url = Uri.parse("$_baseUrl/beststories.json");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final ids =
          response.body.substring(1, response.body.length - 2).split(",");

      return ids.map((id) => int.parse(id)).toList();
    }

    throw _handleError(response);
  }

  Future<Story> getStory(int id) async {
    final url = Uri.parse("$_baseUrl/item/$id.json");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return Story.fromJson(json);
    }

    throw _handleError(response);
  }

  Future<Comment> getComment(int id) async {
    final url = Uri.parse("$_baseUrl/item/$id.json");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return Comment.fromJson(json);
    }

    throw _handleError(response);
  }

  HttpException _handleError(http.Response response) {
    return HttpException(
        "Request failed with status code ${response.statusCode}",
        uri: response.request?.url);
  }
}
