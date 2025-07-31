import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/pull_request.dart';
import '../utils/date_formatter.dart';

class PullRequestCard extends StatelessWidget {
  final PullRequest pullRequest;

  const PullRequestCard({Key? key, required this.pullRequest})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: InkWell(
        onTap: () => _launchUrl(pullRequest.htmlUrl),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(pullRequest.authorAvatarUrl),
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pullRequest.authorUsername,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          DateFormatter.formatRelativeTime(
                            pullRequest.createdAt,
                          ),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: Text('#${pullRequest.number}'),
                    backgroundColor: Colors.blue[50],
                    labelStyle: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                pullRequest.title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              if (pullRequest.body != null && pullRequest.body!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  pullRequest.body!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
