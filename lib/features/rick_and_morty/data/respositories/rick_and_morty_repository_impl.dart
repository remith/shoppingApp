import 'package:dartz/dartz.dart';

import 'package:shopping_app/core/error/failure.dart';

import 'package:shopping_app/features/rick_and_morty/domain/entities/character.dart';

import '../../domain/repositories/rick_and_morty_repository_protocol.dart';
import '../datasources/rick_and_morty_remote_data_source.dart';

class RickAndMortyRepositoryProtocolImpl
    extends RickAndMortyRepositoryProtocol {
  final RickAndMortyRemoteDatasource rickAndMortyRemoteDatasource;

  RickAndMortyRepositoryProtocolImpl(
      {required this.rickAndMortyRemoteDatasource});
  @override
  Future<Either<Failure, Character>> fetchCharacterDetail(
      {required String characterID}) async {
    return await rickAndMortyRemoteDatasource.fetchCharacterDetail(
        characterID: characterID);
  }

  @override
  Future<Either<Failure, List<Character>>> fetchCharacters() async {
    return await rickAndMortyRemoteDatasource.fetchCharacters();
  }
}
