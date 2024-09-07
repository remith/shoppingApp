import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/features/rick_and_morty/data/datasources/rick_and_morty_remote_data_source.dart';
import 'package:shopping_app/features/rick_and_morty/data/respositories/rick_and_morty_repository_impl.dart';
import 'package:shopping_app/features/rick_and_morty/domain/repositories/rick_and_morty_repository_protocol.dart';
import 'package:shopping_app/features/rick_and_morty/domain/usecases/fetch_characters_usecase.dart';

import '../../../../core/platform/graph_ql_client.dart';
import '../../domain/entities/character.dart';
import '../providers/rick_and_morty_providers.dart';

class CharacterListScreen extends StatelessWidget {
  final List<Character> characters;
  const CharacterListScreen({
    super.key,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
      ),
      body: MultiProvider(
        providers: [
          Provider<RickAndMortyRemoteDatasource>(
            create: (_) => RickAndMortyRemoteDatasourceImpl(
              graphQLClientWrapper: context.read<GraphQLClientWrapper>(),
            ),
          ),
          Provider<RickAndMortyRepositoryProtocol>(
            create: (context) => RickAndMortyRepositoryProtocolImpl(
              rickAndMortyRemoteDatasource:
                  context.read<RickAndMortyRemoteDatasource>(),
            ),
          ),
          Provider<FetchCharactersUsecase>(
            create: (context) => FetchCharactersUsecase(
              rickAndMortyRepositoryProtocol:
                  context.read<RickAndMortyRepositoryProtocol>(),
            ),
          ),
          ChangeNotifierProvider<RickAndMortyProvider>(
            create: (context) => RickAndMortyProvider(
              fetchCharactersUsecase: context.read<FetchCharactersUsecase>(),
            ),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              itemCount: characters.length,
              itemBuilder: (BuildContext context, int index) {
                final character = characters[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Character Image
                    Center(
                      child: Image.network(
                        character.image,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Character Details
                    Text(
                      'Name: ${character.name}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Species: ${character.species}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Status: ${character.status}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Gender: ${character.gender}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16.0),

                    // Episodes List
                    Text(
                      'Episodes:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: character.episodes?.length ?? 0,
                        itemBuilder: (context, index) {
                          final episode = character.episodes?[index];
                          return ListTile(
                            leading: const Icon(Icons.tv),
                            title: Text(episode?.name ?? ''),
                            subtitle: Text('Episode: ${episode?.episode}'),
                            trailing: Text(episode?.airDate ?? ''),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
