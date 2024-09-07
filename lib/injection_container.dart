import 'package:shopping_app/core/platform/rest_api_client.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/services/firebase_authentication_service.dart';

final sl = GetIt.instance;

void initializeDependencies() {
  //! Features

  // LOGIN
  // cubit
  // sl.registerFactory(
  //   () => ProductsCubit(
  //     fetchProductListUseCase: sl(),
  //   ),
  // );
  // // usecase
  // sl.registerLazySingleton(
  //   () => FetchProductListUseCase(
  //     fetchProductListRepository: sl(),
  //   ),
  // );
  // // repository
  // sl.registerLazySingleton<FetchProductListRepository>(
  //   () => FetchProductListRepositoryImplementation(
  //     fetchProductListRemotedataSource: sl(),
  //   ),
  // );

  // // datasources
  // sl.registerLazySingleton<FetchProductListRemotedataSource>(
  //   () => FetchProductListRemotedataSourceImplementation(
  //     netwrokClient: sl(),
  //   ),
  // );

  // Cart

  // cubit
  // sl.registerFactory(
  //   () => CartCubit(),
  // );
  // // usecase
  // sl.registerLazySingleton(
  //   () => RegisterUserUsecase(
  //     registerUserRepository: sl(),
  //   ),
  // );
  // // repository
  // sl.registerLazySingleton<RegisterUserRepository>(
  //   () => RegisterUserRepositoryImplementation(
  //     remoteDatasource: sl(),
  //   ),
  // );

  // // datasources
  // sl.registerLazySingleton<RegisterUserRemoteDatasource>(
  //   () => RegisterUserRemoteDatasourceImplementation(
  //     httpClient: sl(),
  //   ),
  // );

  //! External Libraries
  sl.registerLazySingleton(
    () => http.Client(),
  );

  sl.registerLazySingleton(() => FirebaseAuthenticationService());

  sl.registerLazySingleton(() => RestApiClient());
}
