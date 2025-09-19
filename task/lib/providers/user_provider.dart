import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/api_service.dart';

enum UserState { loading, loaded, error, empty }

class UserProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<User> _users = [];
  List<User> _filteredUsers = [];
  UserState _state = UserState.loading;
  String _errorMessage = '';
  String _searchQuery = '';

  // Getters
  List<User> get users => _filteredUsers;
  UserState get state => _state;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  bool get hasUsers => _users.isNotEmpty;

  /// Initial load of users
  Future<void> loadUsers() async {
    _setState(UserState.loading);
    
    try {
      final users = await _apiService.getUsers();
      _users = users;
      _filteredUsers = users;
      _setState(users.isEmpty ? UserState.empty : UserState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(UserState.error);
    }
  }

  /// Refresh users (for pull-to-refresh)
  Future<void> refreshUsers() async {
    try {
      final users = await _apiService.getUsers();
      _users = users;
      _applySearchFilter();
      _setState(users.isEmpty ? UserState.empty : UserState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(UserState.error);
    }
  }

  /// Search users by name
  void searchUsers(String query) {
    _searchQuery = query;
    _applySearchFilter();
    notifyListeners();
  }

  /// Clear search and show all users
  void clearSearch() {
    _searchQuery = '';
    _filteredUsers = _users;
    notifyListeners();
  }

  /// Apply search filter to users
  void _applySearchFilter() {
    if (_searchQuery.isEmpty) {
      _filteredUsers = _users;
    } else {
      _filteredUsers = _users.where((user) {
        return user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               user.username.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  /// Set state and notify listeners
  void _setState(UserState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Get user by ID
  User? getUserById(int id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }
}