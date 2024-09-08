import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/usecases/params.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/character.dart';
import '../repositories/rick_and_morty_repository_protocol.dart';

class FetchCharactersUsecase extends UseCase<List<Character>, NoParam> {
  final RickAndMortyRepositoryProtocol rickAndMortyRepositoryProtocol;

  FetchCharactersUsecase({required this.rickAndMortyRepositoryProtocol});
  @override
  Future<Either<Failure, List<Character>>> call(NoParam params) async {
    return await rickAndMortyRepositoryProtocol.fetchCharacters();
  }
}
