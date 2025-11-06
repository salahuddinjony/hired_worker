import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../helper/shared_prefe/shared_prefe.dart';
import '../utils/app_const/app_const.dart';
import 'api_url.dart';
import 'package:mime/mime.dart';

class ApiClient extends GetxService {
  static var client = http.Client();

  static const String somethingWentWrong = "Something Went Wrong";
  static const int timeoutInSeconds = 30;

  static String bearerToken =
      "zI0NTAwODI4fQ.dTr7dcjgfk9ChQ2oZQ39MGZBQSntiT8YjvZTZowUXas";

  static void printPrettyJson(dynamic input) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      final pretty = encoder.convert(input);
      printWrapped(pretty);
    } catch (e) {
      debugPrint('Invalid JSON: $e');
    }
  }

  static void printWrapped(String text) {
    final pattern = RegExp('.{1,800}');
    for (final match in pattern.allMatches(text)) {
      debugPrint(match.group(0));
    }
  }

  static Future<Response> getData(
    String uri, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);

    final mainHeaders = {
      'Accept': 'application/json',
      'Authorization': bearerToken,
    };
     // Build final URI with query params (merging any already present in uri)
     if(!uri.startsWith("http" ) && !uri.startsWith("https")){
       uri = ApiUrl.baseUrl+uri;
     }
    Uri baseUri = Uri.parse(uri);
    if (query != null) {
      baseUri = baseUri.replace(queryParameters: query);
    }
    try {
      debugPrint('🚀 ====> GET REQUEST START ====>');
      debugPrint('📍 URL: ${baseUri.toString()}');
      debugPrint('📋 Headers:');
      printPrettyJson(headers ?? mainHeaders);
      if (query != null && query.isNotEmpty) {
        debugPrint('🔍 Query Parameters:');
        printPrettyJson(query);
      }
      debugPrint('⏱️  Timeout: ${timeoutInSeconds}s');

      final http.Response response = await client
          .get(baseUri, headers: headers ?? mainHeaders)
          .timeout(const Duration(seconds: timeoutInSeconds));

      debugPrint('📥 ====> GET RESPONSE START ====>');
      debugPrint('📍 URL: ${baseUri.toString()}');
      debugPrint('📊 Status Code: ${response.statusCode}');
      debugPrint('📋 Response Headers:');
      debugPrint('  content-type: ${response.headers['content-type']}');
      debugPrint('  date: ${response.headers['date']}');
      debugPrint('  server: ${response.headers['server']}');
      debugPrint('  content-length: ${response.headers['content-length']}');
      debugPrint('📄 Response Body:');
      try {
          final prettyJson = const JsonEncoder.withIndent('  ')
            .convert(jsonDecode(response.body));
        debugPrint(prettyJson);
      } catch (e) {
        debugPrint('Response body (not JSON): ${response.body}');
      }
      debugPrint('🏁 ====> GET RESPONSE END ====>');

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('❌ GET REQUEST ERROR for $uri: ${e.toString()}');
      return const Response(statusCode: 1, statusText: somethingWentWrong);
    }
  }

  static Future<Response> postData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
    bool isContentType = true,
  }) async {
    bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);

    final mainHeaders =
        isContentType
            ? {'Content-Type': 'application/json', 'Authorization': bearerToken}
            : {'Accept': 'application/json', 'Authorization': bearerToken};
    try {
      debugPrint('🚀 ====> POST REQUEST START ====>');
      debugPrint('📍 URL: ${ApiUrl.baseUrl + uri}');
      debugPrint('📋 Headers:');
      printPrettyJson(headers ?? mainHeaders);
      debugPrint('📦 Request Body:');
      if (body != null) {
        try {
          // Try to parse and pretty print if it's JSON
          if (body is String) {
            final decodedBody = jsonDecode(body);
            printPrettyJson(decodedBody);
          } else {
            printPrettyJson(body);
          }
        } catch (e) {
          debugPrint(body.toString());
        }
      } else {
        debugPrint('null');
      }

      final http.Response response = await client
          .post(
            Uri.parse(ApiUrl.baseUrl + uri),
            body: body,
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      
      debugPrint('📥 ====> POST RESPONSE START ====>');
      debugPrint('📍 URL: ${ApiUrl.baseUrl + uri}');
      debugPrint('📊 Status Code: ${response.statusCode}');
      debugPrint('📋 Response Headers:');
      printPrettyJson(response.headers);
      debugPrint('📄 Response Body:');
      try {
        final prettyJson = const JsonEncoder.withIndent('  ')
            .convert(jsonDecode(response.body));
        debugPrint(prettyJson);
      } catch (e) {
        debugPrint('Response body (not JSON): ${response.body}');
      }
      debugPrint('🏁 ====> POST RESPONSE END ====>');
      
      return handleResponse(response, uri);
    } catch (e, s) {
      debugPrint('❌ POST REQUEST ERROR for ${ApiUrl.baseUrl + uri}:');
      debugPrint('Error: ${e.toString()}');
      debugPrint('Stack trace: ${s.toString()}');

      return const Response(statusCode: 1, statusText: somethingWentWrong);
    }
  }

  static Future<Response> patchData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
    bool isContentType = true,
  }) async {
    bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);

    final mainHeaders =
        isContentType
            ? {'Content-Type': 'application/json', 'Authorization': bearerToken}
            : {'Accept': 'application/json', 'Authorization': bearerToken};
    try {
      debugPrint('🚀 ====> PATCH REQUEST START ====>');
      debugPrint('📍 URL: ${ApiUrl.baseUrl + uri}');
      debugPrint('📋 Headers:');
      printPrettyJson(headers ?? mainHeaders);
      debugPrint('📦 Request Body:');
      if (body != null) {
        try {
          if (body is String) {
            final decodedBody = jsonDecode(body);
            printPrettyJson(decodedBody);
          } else {
            printPrettyJson(body);
          }
        } catch (e) {
          debugPrint(body.toString());
        }
      } else {
        debugPrint('null');
      }

      final http.Response response = await client
          .patch(
            Uri.parse(ApiUrl.baseUrl + uri),
            body: body,
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      
      debugPrint('📥 ====> PATCH RESPONSE START ====>');
      debugPrint('📍 URL: ${ApiUrl.baseUrl + uri}');
      debugPrint('📊 Status Code: ${response.statusCode}');
      debugPrint('📋 Response Headers:');
      printPrettyJson(response.headers);
      debugPrint('📄 Response Body:');
      try {
        final prettyJson = const JsonEncoder.withIndent('  ')
            .convert(jsonDecode(response.body));
        debugPrint(prettyJson);
      } catch (e) {
        debugPrint('Response body (not JSON): ${response.body}');
      }
      debugPrint('🏁 ====> PATCH RESPONSE END ====>');
      
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('❌ PATCH REQUEST ERROR for ${ApiUrl.baseUrl + uri}: ${e.toString()}');

      return const Response(statusCode: 1, statusText: somethingWentWrong);
    }
  }

  static Future<Response> putData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);

    final mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': bearerToken,
    };
    try {
      debugPrint('====> API Call (PUT): $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');

      final http.Response response = await http
          .put(
            Uri.parse(ApiUrl.baseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      
      debugPrint('📥 ====> PUT RESPONSE START ====>');
      debugPrint('📍 URL: ${ApiUrl.baseUrl + uri}');
      debugPrint('📊 Status Code: ${response.statusCode}');
      debugPrint('📋 Response Headers:');
      printPrettyJson(response.headers);
      debugPrint('📄 Response Body:');
      try {
        final prettyJson = const JsonEncoder.withIndent('  ')
            .convert(jsonDecode(response.body));
        debugPrint(prettyJson);
      } catch (e) {
        debugPrint('Response body (not JSON): ${response.body}');
      }
      debugPrint('🏁 ====> PUT RESPONSE END ====>');
      
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('❌ PUT REQUEST ERROR for ${ApiUrl.baseUrl + uri}: ${e.toString()}');
      return const Response(statusCode: 1, statusText: somethingWentWrong);
    }
  }

  static Future<Response> postMultipartData(
      String uri,
      dynamic body, {
        List<MultipartBody>? multipartBody,
        Map<String, String>? headers,
      }) async {
    try {
      bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);

      final mainHeaders = {
        'Accept': 'application/json',
        'Authorization': bearerToken,
      };

      debugPrint('🚀 ====> POST MULTIPART REQUEST START ====>');
      debugPrint('📍 URL: ${ApiUrl.baseUrl + uri}');
      debugPrint('📋 Headers:');
      printPrettyJson(headers ?? mainHeaders);
      debugPrint('📦 Request Body Fields:');
      printPrettyJson(body);
      debugPrint('📷 Multipart Files: ${multipartBody?.length ?? 0} files');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.baseUrl + uri),
      );

      // Convert all body values to strings
      final bodyMap = Map<String, String>.fromEntries(
          (body as Map).entries.map((entry) =>
              MapEntry(entry.key, entry.value.toString())
          )
      );

      request.fields.addAll(bodyMap);

      if (multipartBody != null && multipartBody.isNotEmpty) {
        for (final element in multipartBody) {
          debugPrint("📁 File path: ${element.file.path}");
          final mimeType = lookupMimeType(element.file.path);
          debugPrint("🎭 MimeType: $mimeType");

          final multipartImg = await http.MultipartFile.fromPath(
            element.key,
            element.file.path,
            contentType: MediaType.parse(mimeType!),
          );
          request.files.add(multipartImg);
        }
      }

      request.headers.addAll(mainHeaders);
      final http.StreamedResponse response = await request.send();
      final content = await response.stream.bytesToString();

      debugPrint('📥 ====> POST MULTIPART RESPONSE START ====>');
      debugPrint('📍 URL: ${ApiUrl.baseUrl + uri}');
      debugPrint('📊 Status Code: ${response.statusCode}');
      debugPrint('📄 Response Body:');
      try {
        printPrettyJson(jsonDecode(content));
      } catch (e) {
        debugPrint('Response body (not JSON): $content');
      }
      debugPrint('🏁 ====> POST MULTIPART RESPONSE END ====>');

      return Response(
        statusCode: response.statusCode,
        statusText: response.reasonPhrase ?? somethingWentWrong,
        body: content,
      );
    } catch (e) {
      debugPrint('❌ POST MULTIPART REQUEST ERROR for ${ApiUrl.baseUrl + uri}: ${e.toString()}');

      return const Response(statusCode: 1, statusText: somethingWentWrong);
    }
  }

  static Future<Response> patchMultipartData(
    String uri,
    dynamic body, {
    List<MultipartBody>? multipartBody,
    Map<String, String>? headers,
  }) async {
    try {
      bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);

      final mainHeaders = {
        'Accept': 'application/json',
        'Authorization': bearerToken,
      };

      debugPrint('🚀 ====> PATCH MULTIPART REQUEST START ====>');
      debugPrint('📍 URL: ${ApiUrl.baseUrl + uri}');
      debugPrint('📋 Headers:');
      printPrettyJson(headers ?? mainHeaders);
      debugPrint('📦 Request Body Fields:');
      printPrettyJson(body);
      debugPrint('📷 Multipart Files: ${multipartBody?.length ?? 0} files');

      final request = http.MultipartRequest(
        'PATCH',
        Uri.parse(ApiUrl.baseUrl + uri),
      );
      request.fields.addAll(body);

      if (multipartBody != null && multipartBody.isNotEmpty) {
        for (final element in multipartBody) {
          debugPrint("📁 File path: ${element.file.path}");
          final mimeType = lookupMimeType(element.file.path);
          debugPrint("🎭 MimeType: $mimeType");

          final multipartImg = await http.MultipartFile.fromPath(
            element.key,
            element.file.path,
            contentType: MediaType.parse(mimeType!),
          );
          request.files.add(multipartImg);
        }
      }

      request.headers.addAll(mainHeaders);
      final http.StreamedResponse response = await request.send();
      final content = await response.stream.bytesToString();
      
      debugPrint('📥 ====> PATCH MULTIPART RESPONSE START ====>');
      debugPrint('📍 URL: ${ApiUrl.baseUrl + uri}');
      debugPrint('📊 Status Code: ${response.statusCode}');
      debugPrint('📄 Response Body:');
      try {
        printPrettyJson(jsonDecode(content));
      } catch (e) {
        debugPrint('Response body (not JSON): $content');
      }
      debugPrint('🏁 ====> PATCH MULTIPART RESPONSE END ====>');

      return Response(
        statusCode: response.statusCode,
        statusText: somethingWentWrong,
        body: content,
      );
    } catch (e) {
      debugPrint('❌ PATCH MULTIPART REQUEST ERROR for ${ApiUrl.baseUrl + uri}: ${e.toString()}');

      return const Response(statusCode: 1, statusText: somethingWentWrong);
    }
  }

  static Future<Response> putMultipartData(
    String uri,
    Map<String, String> body, {
    List<MultipartBody>? multipartBody,
    List<MultipartListBody>? multipartListBody,
    Map<String, String>? headers,
  }) async {
    try {
      bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);

      final mainHeaders = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': bearerToken,
      };

      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body with ${multipartBody?.length} picture');

      final request = http.MultipartRequest(
        'PUT',
        Uri.parse(ApiUrl.baseUrl + uri),
      );
      request.fields.addAll(body);

      if (multipartBody!.isNotEmpty) {
        for (final element in multipartBody) {
          debugPrint("path : ${element.file.path}");

          if (element.file.path.contains(".mp4")) {
            debugPrint("media type mp4 ==== ${element.file.path}");
            request.files.add(
              http.MultipartFile(
                element.key,
                element.file.readAsBytes().asStream(),
                element.file.lengthSync(),
                filename: 'video.mp4',
                contentType: MediaType('video', 'mp4'),
              ),
            );
          } else if (element.file.path.contains(".png")) {
            debugPrint("media type png ==== ${element.file.path}");
            request.files.add(
              http.MultipartFile(
                element.key,
                element.file.readAsBytes().asStream(),
                element.file.lengthSync(),
                filename: 'image.png',
                contentType: MediaType('image', 'png'),
              ),
            );
          }
        }
      }

      request.headers.addAll(mainHeaders);
      final http.StreamedResponse response = await request.send();
      final content = await response.stream.bytesToString();
      debugPrint('====> API Response: [${response.statusCode}] $uri');
      printPrettyJson(jsonDecode(content));

      return Response(
        statusCode: response.statusCode,
        statusText: somethingWentWrong,
        body: content,
      );
    } catch (e) {
      return const Response(statusCode: 1, statusText: somethingWentWrong);
    }
  }

  static Future<Response> deleteData(
    String uri, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);

    final mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': bearerToken,
    };
    try {
      debugPrint('🚀 ====> DELETE REQUEST START ====>');
      debugPrint('📍 URL: ${ApiUrl.baseUrl + uri}');
      debugPrint('📋 Headers:');
      printPrettyJson(headers ?? mainHeaders);
      if (body != null) {
        debugPrint('📦 Request Body:');
        try {
          if (body is String) {
            final decodedBody = jsonDecode(body);
            printPrettyJson(decodedBody);
          } else {
            printPrettyJson(body);
          }
        } catch (e) {
          debugPrint(body.toString());
        }
      }

      final http.Response response = await http
          .delete(
            Uri.parse(ApiUrl.baseUrl + uri),
            headers: headers ?? mainHeaders,
            body: body,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      
      debugPrint('📥 ====> DELETE RESPONSE START ====>');
      debugPrint('📍 URL: ${ApiUrl.baseUrl + uri}');
      debugPrint('📊 Status Code: ${response.statusCode}');
      debugPrint('📋 Response Headers:');
      printPrettyJson(response.headers);
      debugPrint('📄 Response Body:');
      try {
        final prettyJson = const JsonEncoder.withIndent('  ')
            .convert(jsonDecode(response.body));
        debugPrint(prettyJson);
      } catch (e) {
        debugPrint('Response body (not JSON): ${response.body}');
      }
      debugPrint('🏁 ====> DELETE RESPONSE END ====>');
      
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('❌ DELETE REQUEST ERROR for ${ApiUrl.baseUrl + uri}: ${e.toString()}');
      return const Response(statusCode: 1, statusText: somethingWentWrong);
    }
  }

  static Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
        headers: response.request!.headers,
        method: response.request!.method,
        url: response.request!.url,
      ),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0.body is! String) {
      final ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
      response0 = Response(
        statusCode: response0.statusCode,
        body: response0.body,
        statusText: errorResponse.message,
      );
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = const Response(statusCode: 0, statusText: somethingWentWrong);
    }

    return response0;
  }
}

class MultipartBody {
  String key;
  File file;

  MultipartBody(this.key, this.file);
}

class MultipartListBody {
  String key;
  String value;

  MultipartListBody(this.key, this.value);
}

class ErrorResponse {
  final String? status;
  final int? statusCode;
  final String? message;

  ErrorResponse({this.status, this.statusCode, this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
  );
}
