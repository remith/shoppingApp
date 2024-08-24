import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';

import 'dart:developer';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void fetchUserCart() {
    //! TODO: fetching of cart from api
    log('fetchUserCart');

    final userCart = List<CartItem>.from(state.items);

    log('20 >> ${userCart.length}');

    emit(CartLoaded(items: userCart));
  }

  void addProductToCart(Product product) {
    final updatedItems = List<CartItem>.from(state.items);

    final existingItem = updatedItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity++;
    } else {
      updatedItems.add(CartItem(product: product, quantity: 1));
    }

    emit(CartLoaded(items: updatedItems));
  }

  void reduceQuantityByOne(CartItem cartItem) {
    log('remove product from cart');
    final updatedItems = List<CartItem>.from(state.items);

    final index = retrieveIndexOfItem(updatedItems, cartItem);

    if (updatedItems[index].quantity > 1) {
      updatedItems[index] = updatedItems[index]
          .copyWith(quantity: updatedItems[index].quantity - 1);
    } else {
      updatedItems.remove(updatedItems[index]);
    }
    emit(CartLoaded(items: updatedItems));
  }

  void increaseQuantityByOne(CartItem cartItem) {
    final updatedItems = List<CartItem>.from(state.items);

    final index = retrieveIndexOfItem(updatedItems, cartItem);

    if (index != -1) {
      final existingItem = updatedItems[index];
      updatedItems[index] =
          existingItem.copyWith(quantity: existingItem.quantity + 1);
    }

    emit(CartLoaded(items: updatedItems));
  }

  int retrieveIndexOfItem(List<CartItem> cartItems, CartItem cartItem) {
    return cartItems
        .indexWhere((item) => item.product.id == cartItem.product.id);
  }
}
