import 'dart:convert';

import 'package:rick_and_morty/features/rick_and_morty/data/models/episode_model.dart';
import 'package:rick_and_morty/features/rick_and_morty/domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.image,
    required super.name,
    super.episodes,
    super.gender,
    super.species,
    super.status,
    super.type,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    var list = (json['episode'] as List?) ?? [];
    List<EpisodeModel> episodeList =
        list.map((jsonMap) => EpisodeModel.fromJson(jsonMap)).toList();

    return CharacterModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      episodes: episodeList,
      gender: json['gender'] ?? '',
      species: json['species'] ?? '',
      status: json['status'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
