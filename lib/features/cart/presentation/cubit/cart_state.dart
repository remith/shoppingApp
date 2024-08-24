part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState({this.items = const []});

  final List<CartItem> items;

  int get itemCount => items.length;

  @override
  List<Object> get props => [items];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {
  final String? message;

  const CartLoading({required this.message});
}

final class CartLoaded extends CartState {
  const CartLoaded({required super.items});
}

final class CartLoadFailure extends CartState {
  final String? message;

  const CartLoadFailure({this.message});
}
