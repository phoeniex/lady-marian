import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marian/domain/auth/repositories/auth_repository.dart';

part 'pin_logic_state.dart';

class PinLoginCubit extends Cubit<PinLoginState> {
  final AuthRepository _authRepository;

  PinLoginCubit({required AuthRepository authRepository}) :
        _authRepository = authRepository,
        super(const PinLoginState());

  void enterPin(String pinCode) async {
    if (state.pinCode.length >= 6) return;

    final newPinCode = state.pinCode + pinCode;
    if (newPinCode.length == 6) {
      emit(state.copyWith(pinCode: newPinCode));

      final passVerified = await _authRepository.verifyPinCode(pinCode: newPinCode);
      passVerified.fold(
              (left) =>  emit(state.copyWith(behavior: PinLoginBehavior.failure, pinCode: '')),
              (right) => _verifySuccess(right),
      );
    } else {
      emit(state.copyWith(behavior: PinLoginBehavior.inputting, pinCode: newPinCode));
    }
  }

  void removePin() {
    if (state.pinCode.isEmpty) return;
    final newPinCode = state.pinCode.substring(0, state.pinCode.length - 1);

    emit(state.copyWith(behavior: PinLoginBehavior.inputting, pinCode: newPinCode));
  }

  void _verifySuccess(bool passVerified) {
    if (passVerified) {
      emit(state.copyWith(behavior: PinLoginBehavior.success));
    } else {
      emit(state.copyWith(behavior: PinLoginBehavior.failure, pinCode: ''));
    }
  }

}