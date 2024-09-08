// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:rick_and_morty/core/usecases/params.dart';
// import 'package:rick_and_morty/features/rick_and_morty/domain/usecases/fetch_characters_usecase.dart';

// import '../../../../core/error/failure.dart';
// import '../../domain/entities/character.dart';

// part 'rick_and_morty_state.dart';

// class RickAndMortyCubit extends Cubit<RickAndMortyState> {
//   RickAndMortyCubit({required this.fetchCharactersUsecase})
//       : super(RickAndMortyInitial());

//   final FetchCharactersUsecase fetchCharactersUsecase;

//   Future<void> fetchCharacters() async {
//     emit(const LoadingData(loadingMessage: 'Loading characters'));

//     final result = await fetchCharactersUsecase.call(NoParam());

//     result.fold(
//       (failure) {
//         emit(
//           DataLoadFailure(
//               failureMessage: failure is APIFailure
//                   ? (failure.message ?? 'Default error message')
//                   : 'Unknown error, causing failure'),
//         );
//       },
//       (success) {
//         emit(
//           DataLoaded(characters: success),
//         );
//       },
//     );
//   }
// }
