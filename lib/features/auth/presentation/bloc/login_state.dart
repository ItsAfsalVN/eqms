enum LoginStatus { idle, loading, success, failure }

class LoginState {
  final LoginStatus status;
  final String? errorMessage;

  const LoginState({this.status = LoginStatus.idle, this.errorMessage});

  LoginState copyWith({LoginStatus? status, String? errorMessage}) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
