import 'package:equatable/equatable.dart';
import 'package:shopping_app/features/rick_and_morty/domain/entities/episode.dart';

class Character extends Equatable {
  final String id;
  final String image;
  final String name;
  final String? species;
  final String? status;
  final String? gender;
  final String? type;
  final List<Episodes>? episodes;

  const Character({
    required this.id,
    required this.image,
    required this.name,
    this.species,
    this.status,
    this.gender,
    this.type,
    this.episodes,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        name,
        species,
        status,
        gender,
        type,
        episodes,
      ];
}
