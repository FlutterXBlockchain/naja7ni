import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BackendService {
  static BackendService? _instance;
  static BackendService get instance => _instance ??= BackendService._();
  BackendService._();

  int? _currentPort;

  int? get currentPort => _currentPort;


  /// Scan common ports to find running backend server
  Future<int?> detectPort() async {
    final commonPorts = [3000, 3001, 5000, 5001, 8000, 8080, 8081, 64396, 64397, 64398, 64399];
        
    for (final port in commonPorts) {
      try {
        final healthUrl = kIsWeb || Platform.isIOS || Platform.isWindows || Platform.isMacOS || Platform.isLinux
            ? 'http://localhost:$port/api/health'
            : 'http://10.0.2.2:$port/api/health';
                    
        final client = http.Client();
        final response = await client.get(
          Uri.parse(healthUrl),
        ).timeout(const Duration(seconds: 2));
        
        client.close();
        
        if (response.statusCode == 200) {
          debugPrint('Found running backend server on port $port!');
          _currentPort = port;
          return port;
        }
      } catch (e) {
        debugPrint('No server found on port $port: $e');
        continue;
      }
    }
    
    return null;
  }
}
