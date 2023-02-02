import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_repository.dart';
import '../../services/auth_service.dart';
import './auth_event.dart';
import './auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc({required this.userRepository}) : super(UnAuthenticated()) {
    on<GoogleSignInRequested>(
      (AuthEvent event, Emitter<AuthState> emit) async {
        emit(AuthLoading());
        try {
          final idToken = await AuthService.googleSignIn();
          final user = await userRepository.signInWithGoogle(idToken);
          emit(Authenticated(user: user));
        } catch (e) {
          emit(AuthError(error: e.toString()));
          emit(UnAuthenticated());
        }
      },
    );
    on<FacebookSignInRequested>(
      (AuthEvent event, Emitter<AuthState> emit) async {
        emit(AuthLoading());
        try {
          final accessToken = await AuthService.facebookSignIn();
          final user = await userRepository.signInWithFacebook(accessToken);
          emit(Authenticated(user: user));
        } catch (e) {
          emit(AuthError(error: e.toString()));
          emit(UnAuthenticated());
        }
      },
    );
  }
}
