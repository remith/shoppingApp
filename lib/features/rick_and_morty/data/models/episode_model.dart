import '../../domain/entities/episode.dart';

class EpisodeModel extends Episodes {
  const EpisodeModel({
    required super.episode,
    required super.createdDate,
    required super.airDate,
    required super.name,
    required super.id,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      episode: json['episode'],
      createdDate: json['createdDate'],
      airDate: json['airDate'],
      name: json['name'],
      id: json['id'],
    );
  }
}
