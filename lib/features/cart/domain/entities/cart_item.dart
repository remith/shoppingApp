import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product.dart';

class CartItem extends Equatable {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 0,
  });

  num get totalPrice => product.price * quantity;

  @override
  List<Object?> get props => [product, quantity];

  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
