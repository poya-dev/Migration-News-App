import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/preferences/language_prefs.dart';

import '../../repositories/user_repository.dart';
import '../../services/auth_service.dart';
import '../../preferences/user_prefs.dart';
import './auth_event.dart';
import './auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc({required this.userRepository}) : super(UnAuthenticated()) {
    on<IsUserLoggedIn>((AuthEvent event, Emitter<AuthState> emit) async {
      emit(AuthLoading());
      final user = UserPrefs.getUser();
      if (user != null) {
        return emit(Authenticated(user: user));
      }
      emit(UnAuthenticated());
    });
    on<GoogleSignInRequested>(
      (AuthEvent event, Emitter<AuthState> emit) async {
        emit(AuthLoading());
        try {
          final idToken = await AuthService.googleSignIn();
          final user = await userRepository.signInWithGoogle(idToken);
          UserPrefs.setUser(user);
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
    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        UserPrefs.removeUser();
        LanguagePrefs.removeLocale();
        Future.delayed(Duration(seconds: 1));
        await AuthService.signOut();
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });
  }
}
