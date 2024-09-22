import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:shopping_app/features/login/presentation/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: const Login(),
    );
  }
}
