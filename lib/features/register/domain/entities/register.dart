import 'package:equatable/equatable.dart';

class RegisterUser extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String fullName;

  const RegisterUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.fullName,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        fullName,
      ];
}
