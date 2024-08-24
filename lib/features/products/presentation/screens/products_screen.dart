import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/list_tile_loader.dart';
import 'package:shopping_app/core/widgets/retry_container.dart';
import 'package:shopping_app/injection_container.dart';

import '../../../../core/constant/text_style_constants.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/widgets/my_cart.dart';
import '../cubit/products_cubit.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductsCubit productsCubit;

  @override
  void initState() {
    super.initState();

    productsCubit = sl<ProductsCubit>();

    productsCubit.fetchProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product List',
          style: UITextStyle.header.copyWith(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: const [
          MyCart(),
        ],
      ),
      body: BlocProvider(
        create: (context) => productsCubit,
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const ListTileLoader();
            } else if (state is ProductsLoadFailure) {
              return RetryContainer(
                message: 'Unable to Load, please try again',
                onRetry: () {},
              );
            } else if (state is ProductsLoaded) {
              final products = state.products;

              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.image,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: UITextStyle.header.copyWith(
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Rs ${product.price.toString()}',
                                  style: UITextStyle.body.copyWith(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${product.rating.rate}',
                                      style: UITextStyle.body
                                          .copyWith(fontSize: 12),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '(${product.rating.count} reviews)',
                                      style: UITextStyle.body
                                          .copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.add_shopping_cart),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              context
                                  .read<CartCubit>()
                                  .addProductToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.title} added to cart',
                                    style: UITextStyle.body.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
