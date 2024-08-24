import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

class APIFailure extends Failure {
  const APIFailure({this.message});
  final String? message;
  @override
  List<Object?> get props => [message];
}
