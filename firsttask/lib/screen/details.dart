import 'package:flutter/material.dart';
import '../controller/ucontroller.dart';

class Userdetails extends StatelessWidget {
  final User user;
  
  const Userdetails({super.key, required this.user});

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
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
        title: Text(
          user.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                user.name[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '@${user.username}',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),

            // Contact Information
            _buildInfoSection(
              'Contact Information',
              [
                _buildInfoTile('Email', user.email, Icons.email),
                _buildInfoTile('Phone', user.phone, Icons.phone),
                _buildInfoTile('Website', user.website, Icons.language),
              ],
            ),

            // Address Information
            _buildInfoSection(
              'Address',
              [
                _buildInfoTile('Street', user.address.street, Icons.home),
                _buildInfoTile('Suite', user.address.suite, Icons.apartment),
                _buildInfoTile('City', user.address.city, Icons.location_city),
                _buildInfoTile('Zipcode', user.address.zipcode, Icons.map),
                _buildInfoTile(
                  'Location',
                  'Lat: ${user.address.geo.lat}, Lng: ${user.address.geo.lng}',
                  Icons.pin_drop,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}