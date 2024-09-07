import 'package:equatable/equatable.dart';

class Episodes extends Equatable {
  final String episode;
  final String createdDate;
  final String airDate;
  final String name;
  final String id;

  const Episodes({
    required this.episode,
    required this.createdDate,
    required this.airDate,
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [episode, createdDate, airDate, name, id];
}
