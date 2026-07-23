import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> login({
    required String employeeId,
    required String password,
  }) async {
    // Simulates network latency until API integration is added.
    await Future<void>.delayed(const Duration(milliseconds: 600));

    if (employeeId.trim().isEmpty || password.trim().isEmpty) {
      throw Exception('Employee ID and password are required.');
    }
  }
}
