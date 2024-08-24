import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String status;
  final String avatar;
  final String fullName;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.status,
    required this.avatar,
    required this.fullName,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        status,
        avatar,
        fullName,
      ];
}
