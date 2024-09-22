import 'package:core/constants.dart';
import 'package:core/utils/validators.dart';
import 'package:core/widgets.dart';

import 'package:shopping_app/features/register/constants/register_constants.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/firebase_authentication_service.dart';

import '../../../../injection_container.dart';

import '../../../login/presentation/screens/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final firebaseAuthentication = sl<FirebaseAuthenticationService>();

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      padding: const EdgeInsets.only(left: 46, right: 59),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FlutterLogo(
            size: 100,
            style: FlutterLogoStyle.stacked,
          ),
          const SizedBox(height: 56),
          Text(
            RegisterConstants.signUpWithEamil,
            style: UITextStyle.header.copyWith(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 35),
          CustomTextFormField(
            labelText: RegisterConstants.firstName,
            controller: fullNameController,
            validator: (value) => ValidationUtil.validateRequiredField(
              value,
              RegisterConstants.firstName,
            ),
          ),
          const SizedBox(height: 13),
          CustomTextFormField(
            labelText: SharedConstants.emailAddress,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => ValidationUtil.validateEmail(value),
          ),
          const SizedBox(height: 13),
          CustomTextFormField(
            labelText: SharedConstants.password,
            controller: passwordController,
            isMaskedText: true,
          ),
          const SizedBox(height: 22),
          if (!loader)
            CustomFilledButton(
              label: RegisterConstants.createAccount,
              onPressed: () async {
                setState(() {
                  loader = true;
                });

                final user =
                    await firebaseAuthentication.registerWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                  displayName: fullNameController.text,
                );
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Account created, please login',
                          style: UITextStyle.body.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  } else {
                    loader = false;
                  }
                });
              },
            )
          else
            const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
