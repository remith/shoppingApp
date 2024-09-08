import 'package:provider/provider.dart';
import 'package:rick_and_morty/features/login/presentation/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/platform/graph_ql_client.dart';
import 'features/rick_and_morty/data/datasources/rick_and_morty_remote_data_source.dart';
import 'features/rick_and_morty/data/respositories/rick_and_morty_repository_impl.dart';
import 'features/rick_and_morty/domain/repositories/rick_and_morty_repository_protocol.dart';
import 'features/rick_and_morty/domain/usecases/fetch_characters_usecase.dart';
import 'features/rick_and_morty/presentation/providers/rick_and_morty_providers.dart';
import 'features/rick_and_morty/presentation/screens/character_list_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  di.initializeDependencies();
  runApp(MultiProvider(
    providers: [
      Provider<GraphQLClientWrapper>(
        create: (_) => GraphQLClientWrapper(),
      ),
      Provider<RickAndMortyRemoteDatasource>(
        create: (context) => RickAndMortyRemoteDatasourceImpl(
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
    child: const ShoppingApp(),
  ));
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CharacterListScreen(),
    );
  }
}
