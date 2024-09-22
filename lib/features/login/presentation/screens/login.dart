import 'package:core/core.dart';
import 'package:shopping_app/features/products/presentation/screens/products_screen.dart';
import 'package:shopping_app/features/register/presentation/screens/register.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/firebase_authentication_service.dart';
import '../../../../injection_container.dart';

import '../../constants/login_constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final firebaseAuthentication = sl<FirebaseAuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            LoginConstants.welcomeTo,
            style: UITextStyle.header,
          ),
          const SizedBox(height: 16),
          const FlutterLogo(
            size: 100,
            style: FlutterLogoStyle.stacked,
          ),
          const SizedBox(height: 39),
          Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: emailController,
                  labelText: SharedConstants.emailAddress,
                  validator: (value) => ValidationUtil.validateEmail(value),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: passwordController,
                  labelText: SharedConstants.password,
                  isMaskedText: true,
                  validator: (value) => ValidationUtil.validatePassword(value),
                ),
                const SizedBox(height: 56),
                CustomFilledButton(
                  onPressed: () async {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      final user = await firebaseAuthentication
                          .signInWithEmailAndPassword(
                        emailController.text,
                        passwordController.text,
                      );

                      if (user != null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const ProductsScreen(),
                            ),
                          );
                        });
                      }
                    }
                  },
                  label: LoginConstants.login.toUpperCase(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ),
                );
              },
              child: const Text(
                LoginConstants.createAccount,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
