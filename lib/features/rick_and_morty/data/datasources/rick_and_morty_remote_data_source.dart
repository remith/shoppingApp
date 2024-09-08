import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/platform/graph_ql_client.dart';
import '../../domain/entities/character.dart';

import 'package:flutter/services.dart' show rootBundle;

import '../models/character_model.dart';

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
          image
          gender
          episode {
            episode
            created
            air_date
            name
            id
          }
        }
      }
    }
  ''');

    return queryResult.fold(
      (failure) => Left(failure),
      (json) {
        final List<Map<String, dynamic>> characters =
            (json?['characters']['results'] as List<dynamic>)
                .map((character) => character as Map<String, dynamic>)
                .toList();
        final charactersList = characters
            .map((Map<String, dynamic> character) =>
                CharacterModel.fromJson(character))
            .toList();

        return Right(charactersList);
      },
    );
  }
}
