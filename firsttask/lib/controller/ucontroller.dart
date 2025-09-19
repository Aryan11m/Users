// lib/controller/ucontroller.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] ?? '',
      suite: json['suite'] ?? '',
      city: json['city'] ?? '',
      zipcode: json['zipcode'] ?? '',
      geo: Geo.fromJson(json['geo'] ?? {}),
    );
  }

  String get fullAddress => '$street, $suite, $city - $zipcode';
}

class Geo {
  final String lat;
  final String lng;

  Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: json['lat'] ?? '0',
      lng: json['lng'] ?? '0',
    );
  }
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final Address address;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
      address: Address.fromJson(json['address'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'address': {
        'street': address.street,
        'suite': address.suite,
        'city': address.city,
        'zipcode': address.zipcode,
        'geo': {
          'lat': address.geo.lat,
          'lng': address.geo.lng,
        }
      }
    };
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ));

  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get('/users');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => User.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw ApiException("Server error: ${response.statusCode}", response.statusCode);
      }
    } on DioException catch (e) {
      String errorMessage;
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = "Connection timeout";
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = "Receive timeout";
          break;
        case DioExceptionType.connectionError:
          errorMessage = "No internet connection";
          break;
        case DioExceptionType.badResponse:
          errorMessage = "Server error: ${e.response?.statusCode}";
          break;
        default:
          errorMessage = "Network error: ${e.message}";
      }
      throw ApiException(errorMessage, e.response?.statusCode);
    } catch (e) {
      throw ApiException("Unexpected error: ${e.toString()}");
    }
  }
}

class UserController extends GetxController {
  var users = <User>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final fetchedUsers = await _apiService.getUsers();
      users.value = fetchedUsers;
      
    } catch (e) {
      errorMessage.value = e.toString();
      users.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshUsers() async {
    await fetchUsers();
  }

  void clearError() {
    errorMessage.value = '';
  }
}