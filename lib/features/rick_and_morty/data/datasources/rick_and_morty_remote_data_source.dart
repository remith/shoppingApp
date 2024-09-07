import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/platform/graph_ql_client.dart';
import '../../domain/entities/character.dart';

abstract class RickAndMortyRemoteDatasource {
  Future<Either<Failure, Character>> fetchCharacterDetail({
    required String characterID,
  });

  Future<Either<Failure, List<Character>>> fetchCharacters();
}

class RickAndMortyRemoteDatasourceImpl extends RickAndMortyRemoteDatasource {
  final GraphQLClientWrapper graphQLClientWrapper;

  RickAndMortyRemoteDatasourceImpl({required this.graphQLClientWrapper});

  @override
  Future<Either<Failure, Character>> fetchCharacterDetail(
      {required String characterID}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Character>>> fetchCharacters() async {
    final queryResult = await graphQLClientWrapper.query('''
    query GetCharacters {
      characters {
        results {
          id
          name
          status
        }
      }
    }
  ''');

    return queryResult.fold(
      (failure) => Left(failure),
      (json) {
        log('$json');
        // final list = json
        //     .map(
        //       (json) => CharacterModel.fromJson(json),
        //     )
        //     .toList();
        return Right([]);
      },
    );
  }
}
