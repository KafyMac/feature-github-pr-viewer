import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/pull_request_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/pull_request_card.dart';
import '../widgets/shimmer_loading.dart';
import '../widgets/error_widget.dart';

class PullRequestsScreen extends StatefulWidget {
  const PullRequestsScreen({super.key});

  @override
  State<PullRequestsScreen> createState() => _PullRequestsScreenState();
}

class _PullRequestsScreenState extends State<PullRequestsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PullRequestProvider>().fetchPullRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pull Requests'),
        elevation: 0,
        actions: [
          Consumer<PullRequestProvider>(
            builder: (context, prProvider, child) {
              return IconButton(
                icon:
                    prProvider.isLoading
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Icon(Icons.refresh),
                onPressed:
                    prProvider.isLoading
                        ? null
                        : () => prProvider.refreshPullRequests(),
                tooltip: 'Refresh pull requests',
              );
            },
          ),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(_getThemeIcon(themeProvider.themeMode)),
                onPressed: () => _showThemeDialog(context),
                tooltip: 'Change theme',
              );
            },
          ),
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'token') {
                    _showTokenDialog(context, authProvider.token);
                  } else if (value == 'logout') {
                    authProvider.logout();
                  }
                },
                itemBuilder:
                    (context) => [
                      const PopupMenuItem(
                        value: 'token',
                        child: Row(
                          children: [
                            Icon(Icons.key),
                            SizedBox(width: 8),
                            Text('Show Token'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'logout',
                        child: Row(
                          children: [
                            Icon(Icons.logout),
                            SizedBox(width: 8),
                            Text('Logout'),
                          ],
                        ),
                      ),
                    ],
              );
            },
          ),
        ],
      ),
      body: Consumer<PullRequestProvider>(
        builder: (context, prProvider, child) {
          if (prProvider.isLoading && prProvider.pullRequests.isEmpty) {
            return const ShimmerLoading();
          }

          if (prProvider.error != null && prProvider.pullRequests.isEmpty) {
            return ErrorRetryWidget(
              error: prProvider.error!,
              onRetry: () => prProvider.fetchPullRequests(),
            );
          }

          return RefreshIndicator(
            onRefresh: () => prProvider.refreshPullRequests(),
            child:
                prProvider.pullRequests.isEmpty
                    ? _buildEmptyState(context, prProvider)
                    : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: prProvider.pullRequests.length,
                      itemBuilder: (context, index) {
                        return PullRequestCard(
                          pullRequest: prProvider.pullRequests[index],
                        );
                      },
                    ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    PullRequestProvider prProvider,
  ) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.inbox, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'No open pull requests found',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                'Pull down to refresh or tap the refresh button',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed:
                    prProvider.isLoading
                        ? null
                        : () => prProvider.refreshPullRequests(),
                icon:
                    prProvider.isLoading
                        ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Icon(Icons.refresh),
                label: Text(prProvider.isLoading ? 'Refreshing...' : 'Refresh'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getThemeIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      default:
        return Icons.brightness_auto;
    }
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return AlertDialog(
                title: const Text('Choose Theme'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<ThemeMode>(
                      title: const Row(
                        children: [
                          Icon(Icons.light_mode),
                          SizedBox(width: 8),
                          Text('Light'),
                        ],
                      ),
                      value: ThemeMode.light,
                      groupValue: themeProvider.themeMode,
                      onChanged: (value) {
                        if (value != null) {
                          themeProvider.setThemeMode(value);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Row(
                        children: [
                          Icon(Icons.dark_mode),
                          SizedBox(width: 8),
                          Text('Dark'),
                        ],
                      ),
                      value: ThemeMode.dark,
                      groupValue: themeProvider.themeMode,
                      onChanged: (value) {
                        if (value != null) {
                          themeProvider.setThemeMode(value);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Row(
                        children: [
                          Icon(Icons.brightness_auto),
                          SizedBox(width: 8),
                          Text('System'),
                        ],
                      ),
                      value: ThemeMode.system,
                      groupValue: themeProvider.themeMode,
                      onChanged: (value) {
                        if (value != null) {
                          themeProvider.setThemeMode(value);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          ),
    );
  }

  void _showTokenDialog(BuildContext context, String? token) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Stored Token'),
            content: SelectableText(
              token ?? 'No token found',
              style: const TextStyle(fontFamily: 'monospace'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }
}
