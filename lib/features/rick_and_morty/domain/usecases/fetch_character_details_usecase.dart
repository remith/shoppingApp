import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/usecases/usecase.dart';
import 'package:rick_and_morty/features/rick_and_morty/domain/entities/character.dart';

import '../../../../core/error/failure.dart';
import '../repositories/rick_and_morty_repository_protocol.dart';

class FetchCharacterDetailsUsecase extends UseCase<Character, String> {
  final RickAndMortyRepositoryProtocol rickAndMortyRepositoryProtocol;

  FetchCharacterDetailsUsecase({required this.rickAndMortyRepositoryProtocol});
  @override
  Future<Either<Failure, Character>> call(String params) async {
    return await rickAndMortyRepositoryProtocol.fetchCharacterDetail(
      characterID: params,
    );
  }
}
