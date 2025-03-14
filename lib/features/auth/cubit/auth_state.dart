sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final userData;
  AuthSuccess({required this.userData});
}

class ImageState extends AuthState {}

class LoginState extends AuthState {
  final account;
  LoginState({required this.account});
}
