import 'dart:convert';
import 'package:http/http.dart' as http;
import '../endpoints/endpoints.dart';

class LoginService { //TODO refactor after Dio change.
  // Use ApiConfig for environment-aware URL detection
  static String get baseUrl => ApiEndpoints.apiAuthUrl;

  static const Duration _timeout = Duration(seconds: 10);
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}),
        )
        .timeout(_timeout);

    if (response.statusCode != 200) {
      throw Exception('response not 200');
    } //TODO why do we need this exception here?

    if (response.body.isEmpty) {
      throw Exception(
        'Server returned empty response. Status: ${response.statusCode}',
      );
    } //TODO why do we need this exception here?

    late Map<String, dynamic> responseData;
    try {
      responseData = jsonDecode(response.body); //TODO not needed for Dio
    } catch (jsonError) {
      throw Exception(
        'Invalid JSON response from server. Body: "${response.body.length > 100 ? '${response.body.substring(0, 100)}...' : response.body}"',
      );
    } //TODO why do we need this exception here?

    return responseData;
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}),
        )
        .timeout(_timeout);

    if (response.statusCode != 201) {
      throw Exception('response not 201');
    } //TODO why do we need this exception here?

    if (response.body.isEmpty) {
      throw Exception(
        'Server returned empty response. Status: ${response.statusCode}',
      );
    } //TODO why do we need this exception here?

    late Map<String, dynamic> responseData;
    try {
      responseData = jsonDecode(response.body);
    } catch (jsonError) {
      throw Exception(
        'Invalid JSON response from server. Body: "${response.body.length > 100 ? response.body.substring(0, 100) + '...' : response.body}"',
      );
    } //TODO why do we need this exception here any use?

    return responseData;
  }
}
