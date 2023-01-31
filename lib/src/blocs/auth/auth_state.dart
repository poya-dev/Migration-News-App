import 'package:equatable/equatable.dart';

import '../../models/user.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  Authenticated({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  AuthError({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
