import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'detect_port.dart';
import '../config/api_config.dart';

class ApiService {
  // Use ApiConfig for environment-aware URL detection
  static String get baseUrl => ApiConfig.apiBaseUrl;

  static const Duration _timeout = Duration(seconds: 10);  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      debugPrint('Connection Info: ${getConnectionInfo()}');
      debugPrint('Attempting login to: $baseUrl/login');
      
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      ).timeout(_timeout);

      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response headers: ${response.headers}');
      debugPrint('Response body: "${response.body}"');
      debugPrint('Response body length: ${response.body.length}');

      // Check if response body is empty or not valid JSON
      if (response.body.isEmpty) {
        throw Exception('Server returned empty response. Status: ${response.statusCode}');
      }

      late Map<String, dynamic> responseData;
      try {
        responseData = jsonDecode(response.body);
      } catch (jsonError) {
        debugPrint('JSON decode error: $jsonError');
        throw Exception('Invalid JSON response from server. Body: "${response.body.length > 100 ? response.body.substring(0, 100) + '...' : response.body}"');
      }
      
      if (response.statusCode == 200) {
        debugPrint('Login successful');
        return responseData;
      } else {
        debugPrint('Login failed with status: ${response.statusCode}');
        throw Exception(responseData['message'] ?? 'Login failed');
      }
    } catch (e) {
      debugPrint('Login error: $e');
      rethrow;
    }
  }  Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      debugPrint('Connection Info: ${getConnectionInfo()}');
      debugPrint('Attempting registration to: $baseUrl/register');
      
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      ).timeout(_timeout);

      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response headers: ${response.headers}');
      debugPrint('Response body: "${response.body}"');
      debugPrint('Response body length: ${response.body.length}');

      // Check if response body is empty or not valid JSON
      if (response.body.isEmpty) {
        throw Exception('Server returned empty response. Status: ${response.statusCode}');
      }

      late Map<String, dynamic> responseData;
      try {
        responseData = jsonDecode(response.body);
      } catch (jsonError) {
        debugPrint('JSON decode error: $jsonError');
        throw Exception('Invalid JSON response from server. Body: "${response.body.length > 100 ? response.body.substring(0, 100) + '...' : response.body}"');
      }
      
      if (response.statusCode == 201) {
        debugPrint('Registration successful');
        return responseData;
      } else {
        debugPrint('Registration failed with status: ${response.statusCode}');
        throw Exception(responseData['message'] ?? 'Registration failed');
      }
    } catch (e) {
      debugPrint('Registration error: $e');
      rethrow;
    }
  }

  /// Get current backend connection info for debugging
  static String getConnectionInfo() {
    final backendService = BackendService.instance;
    final port = backendService.currentPort ?? 3000;
    final platform = _getPlatformInfo();
    
    if (kIsWeb) {
      return 'Platform: $platform | URL: http://localhost:$port/api/auth';
    } else if (Platform.isAndroid) {
      return 'Platform: $platform | URL: http://10.0.2.2:$port/api/auth';
    } else {
      return 'Platform: $platform | URL: http://localhost:$port/api/auth';
    }
  }

  /// Get platform information for debugging
  static String _getPlatformInfo() {
    if (kIsWeb) return 'Web Browser';
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isWindows) return 'Windows Desktop';
    if (Platform.isMacOS) return 'macOS Desktop';
    if (Platform.isLinux) return 'Linux Desktop';
    return 'Unknown Platform';
  }
}
