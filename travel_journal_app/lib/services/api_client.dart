import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
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

  static Future<Map<String, String>> authHeadersForImage() async {
    final token = await getToken();
    if (token != null && token.isNotEmpty) {
      return {'Authorization': 'Bearer $token'};
    }
    return {};
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

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    throw ApiException(response.statusCode, utf8.decode(response.bodyBytes));
  }

  static Uri _uri(String path) => Uri.parse('$baseUrl$path');

  static Future<dynamic> _send(Future<http.Response> Function() request) async {
    final response = await request();
    return _handleResponse(response);
  }

  static Future<dynamic> get(String path, {bool auth = true}) async {
    return _send(() async => http.get(_uri(path), headers: await _headers(auth: auth)));
  }

  static Future<dynamic> post(String path, {Map<String, dynamic>? body, bool auth = true}) async {
    return _send(() async => http.post(_uri(path), headers: await _headers(auth: auth), body: body != null ? jsonEncode(body) : null));
  }

  static Future<dynamic> put(String path, {Map<String, dynamic>? body, bool auth = true}) async {
    return _send(() async => http.put(_uri(path), headers: await _headers(auth: auth), body: body != null ? jsonEncode(body) : null));
  }

  static Future<dynamic> patch(String path, {Map<String, dynamic>? body, bool auth = true}) async {
    return _send(() async => http.patch(_uri(path), headers: await _headers(auth: auth), body: body != null ? jsonEncode(body) : null));
  }

  static Future<dynamic> delete(String path, {bool auth = true}) async {
    return _send(() async => http.delete(_uri(path), headers: await _headers(auth: auth)));
  }

  static Future<dynamic> uploadMultipart(
    String path, {
    required Map<String, String> fields,
    required List<MultipartFileSpec> files,
    bool auth = true,
  }) async {
    final request = http.MultipartRequest('POST', _uri(path));
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
      final authHeaders = await _headers(auth: true);
      final token = authHeaders['Authorization'];
      if (token != null) {
        request.headers['Authorization'] = token;
      }
    }
    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);
    return _handleResponse(response);
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
    } catch (e) {
      debugPrint('ApiException body not JSON: $e');
      return 'Server error ($statusCode)';
    }
  }

  @override
  String toString() => 'ApiException($statusCode): $message';
}
