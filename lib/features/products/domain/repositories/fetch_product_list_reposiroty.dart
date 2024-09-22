import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:shopping_app/features/products/domain/entities/product.dart';

abstract class FetchProductListRepository {
  Future<Either<Failure, List<Product>>> fetchProductList();
}
