part of 'products_cubit.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {
  final String loadingMessage;

  const ProductsLoading({required this.loadingMessage});
}

final class ProductsLoaded extends ProductsState {
  final List<Product> products;

  const ProductsLoaded({required this.products});
}

final class ProductsLoadFailure extends ProductsState {
  final String? message;

  const ProductsLoadFailure({this.message});
}
