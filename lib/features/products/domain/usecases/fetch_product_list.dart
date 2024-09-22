import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/product.dart';
import '../repositories/fetch_product_list_reposiroty.dart';

class FetchProductListUseCase extends UseCase<List<Product>, NoParam> {
  final FetchProductListRepository fetchProductListRepository;

  FetchProductListUseCase({required this.fetchProductListRepository});
  @override
  Future<Either<Failure, List<Product>>> call(NoParam params) {
    return fetchProductListRepository.fetchProductList();
  }
}
