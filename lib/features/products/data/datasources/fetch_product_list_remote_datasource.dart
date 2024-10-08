import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:shopping_app/features/products/data/models/product_model.dart';
import 'package:shopping_app/features/products/domain/entities/product.dart';

abstract class FetchProductListRemotedataSource {
  Future<Either<Failure, List<Product>>> fetchProductList();
}

class FetchProductListRemotedataSourceImplementation
    extends FetchProductListRemotedataSource {
  final NetwrokClient netwrokClient;

  FetchProductListRemotedataSourceImplementation({required this.netwrokClient});
  @override
  Future<Either<Failure, List<Product>>> fetchProductList() async {
    final response = await netwrokClient.get(
        apiUrl: '${ApiConstants.fakseStoreUrl}products');
    return response.fold(
      (failure) => Left(failure),
      (success) => Right(
        ProductModel.fromStringList(
          success!.isNotEmpty ? success : [],
        ),
      ),
    );
  }
}
