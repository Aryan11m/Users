import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/user_list_item.dart';
import '../widgets/search_bar_widget.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load users when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUsers();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await context.read<UserProvider>().refreshUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appTitle),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return Column(
            children: [
              // Search Bar
              if (userProvider.hasUsers) ...[
                const SearchBarWidget(),
                const Divider(height: 1),
              ],
              
              // Main Content
              Expanded(
                child: _buildContent(userProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(UserProvider userProvider) {
    switch (userProvider.state) {
      case UserState.loading:
        return const LoadingWidget(message: 'Loading users...');
        
      case UserState.error:
        return CustomErrorWidget(
          message: userProvider.errorMessage,
          onRetry: () => userProvider.loadUsers(),
        );
        
      case UserState.empty:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.people_outline,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                Constants.noUsersMessage,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
        
      case UserState.loaded:
        if (userProvider.users.isEmpty && userProvider.searchQuery.isNotEmpty) {
          return _buildNoSearchResults(userProvider);
        }
        return _buildUserList(userProvider);
    }
  }

  Widget _buildNoSearchResults(UserProvider userProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No users found for "${userProvider.searchQuery}"',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => userProvider.clearSearch(),
            child: const Text('Clear search'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList(UserProvider userProvider) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(Constants.defaultPadding),
        itemCount: userProvider.users.length,
        itemBuilder: (context, index) {
          final user = userProvider.users[index];
          return UserListItem(
            user: user,
            onTap: () => _navigateToUserDetail(user.id),
          );
        },
      ),
    );
  }

  void _navigateToUserDetail(int userId) {
    Navigator.of(context).pushNamed(
      '/user-detail',
      arguments: userId,
    );
    // For now, show a simple dialog since we don't have navigation set up
    _showUserDetailDialog(userId);
  }

  void _showUserDetailDialog(int userId) {
    final user = context.read<UserProvider>().getUserById(userId);
    if (user == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Username', user.username),
            _buildDetailRow('Email', user.email),
            _buildDetailRow('Phone', user.phone),
            _buildDetailRow('Website', user.website),
            _buildDetailRow('Company', user.company.name),
            _buildDetailRow('City', user.address.city),
          ],
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
