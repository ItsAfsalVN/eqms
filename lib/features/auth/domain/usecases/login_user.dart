import '../repositories/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository repository;

  LoginUserUseCase(this.repository);

  Future<void> call({required String employeeId, required String password}) {
    return repository.login(employeeId: employeeId, password: password);
  }
}
