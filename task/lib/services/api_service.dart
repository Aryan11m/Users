import 'package:dio/dio.dart';
import '../models/user.dart';
import '../utils/constants.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  /// Fetches all users from the API
  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get('/users');
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        return jsonData.map((json) => User.fromJson(json)).toList();
      } else {
        throw ApiException(
          'Failed to load users. Server returned ${response.statusCode}',
          response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('Unexpected error occurred: ${e.toString()}');
    }
  }

  ApiException _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('Connection timeout. Please check your internet connection.');
      case DioExceptionType.connectionError:
        return ApiException('No internet connection. Please check your network.');
      case DioExceptionType.badResponse:
        return ApiException(
          'Server error: ${e.response?.statusCode}',
          e.response?.statusCode,
        );
      default:
        return ApiException('Network error occurred. Please try again.');
    }
  }
}