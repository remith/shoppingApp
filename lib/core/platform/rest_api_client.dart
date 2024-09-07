import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../error/exceptions.dart';
import '../error/failure.dart';
import 'package:http/http.dart' as http;

class RestApiClient {
  final Map<String, dynamic>? additionalHeaders;

  RestApiClient({this.additionalHeaders});

  @protected
  final Map<String, String> defaultHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  @mustCallSuper
  Future<Map<String, String>> get headers => Future.value({
        ...defaultHeaders,
        ...Map.from(additionalHeaders ?? {}),
      });

  Future<Either<Failure, Map<String, dynamic>?>> post(
    Map<String, dynamic>? payload, {
    required String apiUrl,
    bool useDefaultHeaders = false,
  }) async {
    final url = apiUrl;
    final headers = useDefaultHeaders ? defaultHeaders : await this.headers;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: payload,
      );
      return Right(jsonDecode(response.body));
    } on HandshakeException catch (e) {
      return Left(APIFailure(message: e.message));
    } on SocketException catch (e) {
      return Left(APIFailure(message: e.message));
    } catch (e) {
      return Left(
        APIFailure(
            message: e is ServerException
                ? e.message
                : 'Unknown exception, try again'),
      );
    }
  }

  Future<Either<Failure, dynamic>> get(
      {required String apiUrl, bool useDefaultHeaders = false}) async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse is List) {
        return Right(
            jsonResponse.map((item) => item as Map<String, dynamic>).toList());
      } else if (jsonResponse is Map) {
        return Right(jsonResponse as Map<String, dynamic>);
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      return Left(
        APIFailure(
          message: e is FormatException
              ? '${e.source} ${e.message}'
              : 'Unknown exception, try again',
        ),
      );
    }
  }
}
