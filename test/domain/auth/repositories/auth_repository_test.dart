import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:marian/data/_shared/failure.dart';
import 'package:marian/data/auth/sources/network/auth_remote.dart';
import 'package:marian/domain/auth/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class AuthMockRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepository authRepository;
  late AuthMockRemoteDataSource mockRemote;

  setUp(() {
    mockRemote = AuthMockRemoteDataSource();
    authRepository = DefaultAuthRepository(remote: mockRemote);
  });

  group('AuthRepository', () {
    test('verifyPinCode should return result when available', () async {
      const pinCode = '123456';
      when(() => mockRemote.verifyPinCode(pinCode: pinCode)).thenAnswer((answer) async => true);

      final result = await authRepository.verifyPinCode(pinCode: pinCode);

      expect(result, equals(fp.right<Failure, bool>(true)));
      verify(() => mockRemote.verifyPinCode(pinCode: pinCode)).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });
}