import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_user.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUserUseCase loginUserUseCase;

  LoginCubit({required this.loginUserUseCase}) : super(const LoginState());

  Future<void> login({
    required String employeeId,
    required String password,
  }) async {
    emit(state.copyWith(status: LoginStatus.loading, errorMessage: null));

    try {
      await loginUserUseCase(employeeId: employeeId, password: password);
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  void resetError() {
    if (state.status == LoginStatus.failure) {
      emit(const LoginState());
    }
  }
}
