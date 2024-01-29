part of 'pin_login_cubit.dart';

enum PinLoginBehavior { initial, inputting, verifying, success, failure }

class PinLoginState extends Equatable {
  final PinLoginBehavior behavior;
  final String pinCode;

  const PinLoginState({
    this.behavior = PinLoginBehavior.initial,
    this.pinCode = '',
  });

  PinLoginState copyWith({
    PinLoginBehavior? behavior,
    String? pinCode,
  }) {
    return PinLoginState(
      behavior: behavior ?? this.behavior,
      pinCode: pinCode ?? this.pinCode,
    );
  }

  @override
  List<Object> get props => [
    behavior,
    pinCode,
  ];
}