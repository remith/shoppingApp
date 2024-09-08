import 'package:rick_and_morty/features/register/domain/entities/register.dart';

class RegisterUserModel extends RegisterUser {
  const RegisterUserModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.fullName,
  });

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserModel(
      email: json['email'],
      firstName: json['firstName'],
      fullName: json['fullName'],
      lastName: json['lastName'],
    );
  }
}
