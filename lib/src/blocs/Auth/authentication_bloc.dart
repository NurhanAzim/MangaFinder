import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_finder/src/utils/services/auth_service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authService = AuthService();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<GoogleAuthEvent>(googleAuthEvent);
    on<SignOutEvent>(signOutEvent);
    on<EmailSignInAuthEvent>(_emailSignInAuthEvent);
    on<EmailSignUpAuthEvent>(_emailSignUpAuthEvent);
  }

  Future<void> googleAuthEvent(
      GoogleAuthEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoadingState());
    try {
      await _authService.signInWithGoogle();
      emit(AuthenticatedState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> signOutEvent(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    try {
      await _authService.signOut();
      emit(UnAuthenticatedState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _emailSignInAuthEvent(
      EmailSignInAuthEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoadingState());
    try {
      await _authService.signInWithEmail(
          email: event.email, password: event.password);
      emit(AuthenticatedState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _emailSignUpAuthEvent(
      EmailSignUpAuthEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoadingState());
    try {
      await _authService.signUpWithEmail(
          email: event.email, password: event.password);
      emit(AuthenticatedState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
