import 'package:fpdart/fpdart.dart' as fp;
import 'package:marian/data/_shared/failure.dart';
import 'package:marian/data/auth/sources/network/auth_remote.dart';

abstract class AuthRepository {
  Future<fp.Either<Failure, bool>> verifyPinCode({required String pinCode});
}

class DefaultAuthRepository implements AuthRepository {
  final AuthRemoteDataSource _remote;

  DefaultAuthRepository({
    required AuthRemoteDataSource remote,
  }) : _remote = remote;

  @override
  Future<fp.Either<Failure, bool>> verifyPinCode({required String pinCode}) async {
    try {
      final passVerified = await _remote.verifyPinCode(pinCode: pinCode);
      return fp.right(passVerified);
    } catch (error) {
      return fp.left(ApiFailure(message: error.toString()));
    }

  }
}