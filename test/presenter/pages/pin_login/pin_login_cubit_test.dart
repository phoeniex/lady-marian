import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:marian/presentation/pages/pin_login/pin_login_cubit.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helper/pump_app.dart';

void main() {
  group('PinLoginCubit', () {
    late MockAuthRepository mockAuthRepository;
    late PinLoginCubit cubit;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      cubit = PinLoginCubit(authRepository: mockAuthRepository);
    });

    test('should have correct initial state', () {
      const expectedState = PinLoginState(
        behavior: PinLoginBehavior.initial,
        pinCode: '',
      );

      expect(PinLoginCubit(authRepository: mockAuthRepository).state, expectedState);
    });

    group('Adding pin code', () {
      blocTest<PinLoginCubit, PinLoginState>('enter first number should store it correctly',
        build: () => cubit,
        act: (cubit) => cubit.enterPin('1'),
        expect: () =>
        [
          const PinLoginState(
            behavior: PinLoginBehavior.inputting,
            pinCode: '1',
          ),
        ],
        verify: (cubit) {
          verifyNoMoreInteractions(mockAuthRepository);
        },
      );

      blocTest<PinLoginCubit, PinLoginState>('enter fourth number should store it correctly',
        build: () => cubit,
        setUp: () {
          cubit.emit(const PinLoginState(
            behavior: PinLoginBehavior.inputting,
            pinCode: '123',
          ));
        },
        act: (cubit) => cubit.enterPin('4'),
        expect: () =>
        [
          const PinLoginState(
            behavior: PinLoginBehavior.inputting,
            pinCode: '1234',
          ),
        ],
        verify: (cubit) {
          verifyNoMoreInteractions(mockAuthRepository);
        },
      );

      blocTest<PinLoginCubit, PinLoginState>('enter sixth number should store it and verify data as success',
        build: () => cubit,
        setUp: () {
          when(() => mockAuthRepository.verifyPinCode(pinCode: '123456')).thenAnswer((answer) async => fp.right(true));
          cubit.emit(const PinLoginState(
            behavior: PinLoginBehavior.inputting,
            pinCode: '12345',
          ));
        },
        act: (cubit) => cubit.enterPin('6'),
        expect: () =>
        [
          const PinLoginState(
            behavior: PinLoginBehavior.inputting,
            pinCode: '123456',
          ),
          const PinLoginState(
            behavior: PinLoginBehavior.success,
            pinCode: '123456',
          ),
        ],
        verify: (cubit) {
          verify(() => mockAuthRepository.verifyPinCode(pinCode: '123456')).called(1);
          verifyNoMoreInteractions(mockAuthRepository);
        },
      );

      blocTest<PinLoginCubit, PinLoginState>('enter wrong sixth number should store it and verify data as failed',
        build: () => cubit,
        setUp: () {
          when(() => mockAuthRepository.verifyPinCode(pinCode: '123450')).thenAnswer((answer) async => fp.right(false));
          cubit.emit(const PinLoginState(
            behavior: PinLoginBehavior.inputting,
            pinCode: '12345',
          ));
        },
        act: (cubit) => cubit.enterPin('0'),
        expect: () =>
        [
          const PinLoginState(
            behavior: PinLoginBehavior.inputting,
            pinCode: '123450',
          ),
          const PinLoginState(
            behavior: PinLoginBehavior.failure,
            pinCode: '',
          ),
        ],
        verify: (cubit) {
          verify(() => mockAuthRepository.verifyPinCode(pinCode: '123450')).called(1);
          verifyNoMoreInteractions(mockAuthRepository);
        },
      );
    });

    group('Removing pin code', () {
      blocTest<PinLoginCubit, PinLoginState>('removing first number should do noting',
        build: () => cubit,
        act: (cubit) => cubit.removePin(),
        expect: () => [],
        verify: (cubit) {
          verifyNoMoreInteractions(mockAuthRepository);
        },
      );

      blocTest<PinLoginCubit, PinLoginState>('removing third number should remove it correctly',
        build: () => cubit,
        setUp: () {
          cubit.emit(const PinLoginState(
            behavior: PinLoginBehavior.inputting,
            pinCode: '123',
          ));
        },
        act: (cubit) => cubit.removePin(),
        expect: () =>
        [
          const PinLoginState(
            behavior: PinLoginBehavior.inputting,
            pinCode: '12',
          ),
        ],
        verify: (cubit) {
          verifyNoMoreInteractions(mockAuthRepository);
        },
      );
    });
  });
}