part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object?> get props => [];
}

class EmailSignInAuthEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const EmailSignInAuthEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class EmailSignUpAuthEvent extends AuthenticationEvent {
  final String email, password;

  const EmailSignUpAuthEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class GoogleAuthEvent extends AuthenticationEvent {
  const GoogleAuthEvent();
}

class SignOutEvent extends AuthenticationEvent {
  const SignOutEvent();
}
