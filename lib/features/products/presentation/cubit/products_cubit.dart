import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/fetch_product_list.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({
    required this.fetchProductListUseCase,
  }) : super(ProductsInitial());

  final FetchProductListUseCase fetchProductListUseCase;

  Future<void> fetchProductList() async {
    emit(const ProductsLoading(loadingMessage: 'Fetching product list'));

    final result = await fetchProductListUseCase.call(NoParam());

    result.fold(
      (failure) => emit(
        ProductsLoadFailure(
          message: failure is APIFailure
              ? failure.message
              : 'Unknown error, causing failure',
        ),
      ),
      (productList) => emit(
        ProductsLoaded(
          products: productList,
        ),
      ),
    );
  }
}
