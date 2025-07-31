class PullRequest {
  final int id;
  final String title;
  final String? body;
  final String authorUsername;
  final String authorAvatarUrl;
  final DateTime createdAt;
  final String htmlUrl;
  final int number;

  PullRequest({
    required this.id,
    required this.title,
    this.body,
    required this.authorUsername,
    required this.authorAvatarUrl,
    required this.createdAt,
    required this.htmlUrl,
    required this.number,
  });

  factory PullRequest.fromJson(Map<String, dynamic> json) {
    return PullRequest(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      authorUsername: json['user']['login'],
      authorAvatarUrl: json['user']['avatar_url'],
      createdAt: DateTime.parse(json['created_at']),
      htmlUrl: json['html_url'],
      number: json['number'],
    );
  }
}
