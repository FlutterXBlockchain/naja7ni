// Production API Configuration
// This file handles environment-specific API URLs

import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../core/helpers/detect_port.dart';

class ApiEndpoints {
  // Production vs Development API URLs
  static const String _productionApiUrl = '$_productionBaseUrl/api/auth';
  static const String _productionBaseUrl = 'https://your-production-api.com';
  
  // Environment detection
  static bool get isProduction => false;
  
  /// Get the appropriate API base URL based on environment
  static String get apiAuthUrl {
    if (isProduction) {
      // Production: Use predefined production URL
      return const String.fromEnvironment('API_URL', defaultValue: _productionApiUrl);
    } else {
      // Development: Use auto-detected URL from BackendService
      final backendService = BackendService.instance;
      final port = backendService.currentPort ?? 3000;
      
      if (kIsWeb) {
        return 'http://localhost:$port/api/auth';
      } else if (Platform.isAndroid) {
        return 'http://10.0.2.2:$port/api/auth';
      } else {
        return 'http://localhost:$port/api/auth';
      }
    }
  }
  
  /// Get base url without /api/auth suffix for custom endpoints
  static String get baseUrl {
    if (isProduction) {
      return const String.fromEnvironment('BASE_URL', defaultValue: _productionBaseUrl);
    } else {
      return apiAuthUrl.replaceAll('/api/auth', '');
    }
  }
  
}
