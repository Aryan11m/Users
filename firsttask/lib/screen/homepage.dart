import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'details.dart';
import '../controller/ucontroller.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final UserController controller = Get.put(UserController());
  final searchQuery = ''.obs;

  List<User> get filteredUsers {
    final query = searchQuery.value.toLowerCase().trim();
    if (query.isEmpty) return controller.users;
    return controller.users.where((user) =>
      user.name.toLowerCase().contains(query) ||
      user.email.toLowerCase().contains(query) ||
      user.username.toLowerCase().contains(query)
    ).toList();
  }

  Widget _buildUserCard(User user) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(
            user.name[0].toUpperCase(),
            style: TextStyle(
              color: Colors.blue.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Get.to(() => Userdetails(user: user)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('Users'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => searchQuery.value = value,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final users = filteredUsers;
        if (users.isEmpty) {
          return const Center(
            child: Text('No users found'),
          );
        }

        return ListView.builder(
          itemCount: users.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) => _buildUserCard(users[index]),
        );
      }),
    );
  }
}