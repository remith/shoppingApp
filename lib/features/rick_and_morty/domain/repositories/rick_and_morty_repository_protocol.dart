import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/character.dart';

abstract class RickAndMortyRepositoryProtocol {
  Future<Either<Failure, Character>> fetchCharacterDetail({
    required String characterID,
  });

  Future<Either<Failure, List<Character>>> fetchCharacters();
}
