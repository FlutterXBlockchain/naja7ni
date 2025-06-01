// Production API Configuration
// This file handles environment-specific API URLs

import 'dart:io';
import 'package:flutter/foundation.dart';
import '../services/detect_port.dart';

class ApiConfig {
  // Production vs Development API URLs
  static const String _productionApiUrl = 'https://your-production-api.com/api/auth';
  static const String _productionBaseUrl = 'https://your-production-api.com';
  
  // Environment detection
  static bool get isProduction => kReleaseMode || 
    const bool.fromEnvironment('PRODUCTION', defaultValue: false);
  
  static bool get isDevelopment => !isProduction;
  
  /// Get the appropriate API base URL based on environment
  static String get apiBaseUrl {
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
  
  /// Get base URL without /api/auth suffix for custom endpoints
  static String get baseUrl {
    if (isProduction) {
      return const String.fromEnvironment('BASE_URL', defaultValue: _productionBaseUrl);
    } else {
      return apiBaseUrl.replaceAll('/api/auth', '');
    }
  }
  
}
