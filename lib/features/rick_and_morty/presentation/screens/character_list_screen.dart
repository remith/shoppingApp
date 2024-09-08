import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/features/rick_and_morty/data/datasources/rick_and_morty_remote_data_source.dart';
import 'package:rick_and_morty/features/rick_and_morty/data/respositories/rick_and_morty_repository_impl.dart';
import 'package:rick_and_morty/features/rick_and_morty/domain/repositories/rick_and_morty_repository_protocol.dart';
import 'package:rick_and_morty/features/rick_and_morty/domain/usecases/fetch_characters_usecase.dart';

import '../../../../core/platform/graph_ql_client.dart';
import '../../domain/entities/character.dart';
import '../providers/rick_and_morty_providers.dart';

class CharacterListScreen extends StatefulWidget {
  // final List<Character> characters;
  const CharacterListScreen({
    super.key,
    // required this.characters,
  });

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RickAndMortyProvider>().fetchCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RickAndMortyProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
      ),
      body: ListView.builder(
        itemCount: provider.characters.length,
        itemBuilder: (context, index) {
          final character = provider.characters[index];
          return Card(
            child: ListTile(
              leading: Image.network(
                character.image,
                width: 50,
              ),
              title: Text(character.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status: ${character.status}'),
                  const SizedBox(height: 10),
                  const Text('Featured Episodes:'),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: character.episodes?.length,
                      itemBuilder: (context, epIndex) {
                        return Chip(
                          label: Text('Episode ${epIndex + 1}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
