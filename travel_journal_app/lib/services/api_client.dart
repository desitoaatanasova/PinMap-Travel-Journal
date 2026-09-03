import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pinmap_travel_journal/services/api_config.dart';

class MultipartFileSpec {
  final String field;
  final Uint8List bytes;
  final String filename;
  final String contentType;

  MultipartFileSpec({
    required this.field,
    required this.bytes,
    required this.filename,
    this.contentType = 'application/octet-stream',
  });
}

class ApiClient {
  static String get baseUrl => ApiConfig.apiBaseUrl;
  static const String _tokenKey = 'auth_token';

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<Map<String, String>> _headers({bool auth = true}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
    };
    if (auth) {
      final token = await getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  static Future<dynamic> get(String path, {bool auth = true}) async {
    final response = await http.get(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(auth: auth),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    throw ApiException(response.statusCode, utf8.decode(response.bodyBytes));
  }

  static Future<dynamic> post(String path, {Map<String, dynamic>? body, bool auth = true}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(auth: auth),
      body: body != null ? jsonEncode(body) : null,
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    throw ApiException(response.statusCode, utf8.decode(response.bodyBytes));
  }

  static Future<dynamic> put(String path, {Map<String, dynamic>? body, bool auth = true}) async {
    final response = await http.put(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(auth: auth),
      body: body != null ? jsonEncode(body) : null,
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    throw ApiException(response.statusCode, utf8.decode(response.bodyBytes));
  }

  static Future<dynamic> patch(String path, {Map<String, dynamic>? body, bool auth = true}) async {
    final response = await http.patch(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(auth: auth),
      body: body != null ? jsonEncode(body) : null,
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    throw ApiException(response.statusCode, utf8.decode(response.bodyBytes));
  }

  static Future<dynamic> delete(String path, {bool auth = true}) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(auth: auth),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    throw ApiException(response.statusCode, utf8.decode(response.bodyBytes));
  }

  static Future<dynamic> uploadMultipart(
    String path, {
    required Map<String, String> fields,
    required List<MultipartFileSpec> files,
    bool auth = true,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl$path'));
    request.fields.addAll(fields);
    for (final file in files) {
      final parts = file.contentType.split('/');
      request.files.add(http.MultipartFile.fromBytes(
        file.field,
        file.bytes,
        filename: file.filename,
        contentType: MediaType(parts.length == 2 ? parts[0] : 'application', parts.length == 2 ? parts[1] : 'octet-stream'),
      ));
    }
    if (auth) {
      final token = await getToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
    }
    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    throw ApiException(response.statusCode, utf8.decode(response.bodyBytes));
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String body;
  ApiException(this.statusCode, this.body);

  String get message {
    try {
      final json = jsonDecode(body);
      return json['error'] ?? 'Unknown error';
    } catch (_) {
      return 'Server error ($statusCode)';
    }
  }

  @override
  String toString() => 'ApiException($statusCode): $message';
}
