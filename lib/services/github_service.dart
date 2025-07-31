import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pull_request.dart';

class GitHubService {
  static const String baseUrl = 'https://api.github.com';
  // Replace with your actual repository
  static const String owner = 'flutter';
  static const String repo = 'flutter';

  Future<List<PullRequest>> fetchPullRequests() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/repos/$owner/$repo/pulls?state=open&per_page=50'),
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          'User-Agent': 'Flutter-PR-Viewer',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => PullRequest.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load pull requests: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
