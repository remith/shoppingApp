import 'dart:developer';

import 'package:authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/features/cart/presentation/cubit/cart_cubit.dart';

import 'package:flutter/material.dart';

import 'features/products/presentation/screens/products_screen.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await AuthenticationLibrary.initializeFirebase();
  AuthenticationLibrary.initialize();
  di.initializeDependencies();
  runApp(BlocProvider(
    create: (context) => sl<CartCubit>(),
    child: const ShoppingApp(),
  ));
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: ThemeData(
        primaryColor: const Color(0XFF011993),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Login(
        onLoginSuccess: (User user, BuildContext context) {
          log('$user');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ProductsScreen(),
            ),
          );
        },
      ),
    );
  }
}
