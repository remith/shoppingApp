import 'package:shopping_app/core/platform/network_client.dart';
import 'package:shopping_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:shopping_app/features/products/data/datasources/fetch_product_list_remote_datasource.dart';
import 'package:shopping_app/features/products/data/respositories/fetch_product_list_repository_implementation.dart';
import 'package:shopping_app/features/products/domain/repositories/fetch_product_list_reposiroty.dart';
import 'package:shopping_app/features/products/domain/usecases/fetch_product_list.dart';
import 'package:shopping_app/features/products/presentation/cubit/products_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/services/firebase_authentication_service.dart';

final sl = GetIt.instance;

void initializeDependencies() {
  //! Features

  // LOGIN
  // cubit
  sl.registerFactory(
    () => ProductsCubit(
      fetchProductListUseCase: sl(),
    ),
  );
  // usecase
  sl.registerLazySingleton(
    () => FetchProductListUseCase(
      fetchProductListRepository: sl(),
    ),
  );
  // repository
  sl.registerLazySingleton<FetchProductListRepository>(
    () => FetchProductListRepositoryImplementation(
      fetchProductListRemotedataSource: sl(),
    ),
  );

  // datasources
  sl.registerLazySingleton<FetchProductListRemotedataSource>(
    () => FetchProductListRemotedataSourceImplementation(
      netwrokClient: sl(),
    ),
  );

  // Cart

  // cubit
  sl.registerFactory(
    () => CartCubit(),
  );
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

  sl.registerLazySingleton(() => NetwrokClient());
}
