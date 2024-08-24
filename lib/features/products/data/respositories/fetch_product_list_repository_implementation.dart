import 'package:dartz/dartz.dart';

import 'package:shopping_app/core/error/failure.dart';

import 'package:shopping_app/features/products/domain/entities/product.dart';

import '../../domain/repositories/fetch_product_list_reposiroty.dart';
import '../datasources/fetch_product_list_remote_datasource.dart';

class FetchProductListRepositoryImplementation
    extends FetchProductListRepository {
  final FetchProductListRemotedataSource fetchProductListRemotedataSource;

  FetchProductListRepositoryImplementation(
      {required this.fetchProductListRemotedataSource});
  @override
  Future<Either<Failure, List<Product>>> fetchProductList() {
    return fetchProductListRemotedataSource.fetchProductList();
  }
}
