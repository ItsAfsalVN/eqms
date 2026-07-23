abstract class AuthRepository {
  Future<void> login({required String employeeId, required String password});
}
