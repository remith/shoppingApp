import 'package:flutter/foundation.dart';
import 'package:shopping_app/core/usecases/params.dart';

import '../../domain/entities/character.dart';
import '../../domain/usecases/fetch_characters_usecase.dart';

class RickAndMortyProvider extends ChangeNotifier {
  final FetchCharactersUsecase fetchCharactersUsecase;

  RickAndMortyProvider({required this.fetchCharactersUsecase});

  List<Character> _characters = [];

  List<Character> get characters => _characters;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchCharacters() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await fetchCharactersUsecase.call(NoParam());
      result.fold(
        (failure) => null,
        (success) {
          _characters = success;
          notifyListeners();
        },
      );
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
