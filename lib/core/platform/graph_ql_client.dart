import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_and_morty/core/constant/api_endpoint.dart';

import '../error/failure.dart';

class GraphQLClientWrapper {
  final Map<String, String>? additionalHeaders;
  final GraphQLClient _client;

  /// Creates an instance of [GraphQLClientWrapper].
  ///
  /// [additionalHeaders] allows you to pass any extra headers needed for requests.
  GraphQLClientWrapper({this.additionalHeaders})
      : _client = GraphQLClient(
          cache: GraphQLCache(store: InMemoryStore()),
          link: HttpLink(
            ApiConstants.graphQLUrl, // Replace with your GraphQL endpoint
            defaultHeaders: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              ...additionalHeaders ?? {},
            },
          ),
        );

  /// Default headers used in GraphQL requests.
  @protected
  final Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Returns a map of headers that includes default headers and any additional headers.
  ///
  /// This method combines default headers with any additional headers provided.
  Future<Map<String, String>> get headers async => {
        ...defaultHeaders,
        ...additionalHeaders ?? {},
      };

  /// Performs a GraphQL query operation.
  ///
  /// [query] is the GraphQL query string to be executed.
  /// [variables] are optional parameters to be passed with the query.
  ///
  /// Returns an [Either] containing either an [APIFailure] or the result of the query.
  Future<Either<Failure, Map<String, dynamic>?>> query(
    String query, {
    Map<String, dynamic>? variables,
  }) async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(query),
          variables: variables ?? {},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      return Right(result.data);
    } catch (e) {
      return Left(
        APIFailure(
          message:
              e is GraphQLError ? e.message : 'Unknown exception, try again',
        ),
      );
    }
  }

  /// Performs a GraphQL mutation operation.
  ///
  /// [mutation] is the GraphQL mutation string to be executed.
  /// [variables] are optional parameters to be passed with the mutation.
  ///
  /// Returns an [Either] containing either an [APIFailure] or the result of the mutation.
  Future<Either<Failure, Map<String, dynamic>?>> mutate(
    String mutation, {
    Map<String, dynamic>? variables,
  }) async {
    try {
      final result = await _client.mutate(
        MutationOptions(
          document: gql(mutation),
          variables: variables ?? {},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      return Right(result.data);
    } catch (e) {
      return Left(
        APIFailure(
          message:
              e is GraphQLError ? e.message : 'Unknown exception, try again',
        ),
      );
    }
  }
}
