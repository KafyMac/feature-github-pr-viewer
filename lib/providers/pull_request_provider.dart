import 'package:flutter/material.dart';
import '../models/pull_request.dart';
import '../services/github_service.dart';

class PullRequestProvider with ChangeNotifier {
  List<PullRequest> _pullRequests = [];
  bool _isLoading = false;
  String? _error;
  final GitHubService _gitHubService = GitHubService();

  List<PullRequest> get pullRequests => _pullRequests;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPullRequests() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _pullRequests = await _gitHubService.fetchPullRequests();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _pullRequests = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshPullRequests() async {
    await fetchPullRequests();
  }
}
