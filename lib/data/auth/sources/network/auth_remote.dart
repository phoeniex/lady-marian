abstract class AuthRemoteDataSource {
  Future<bool>verifyPinCode({required String pinCode});
}

class AuthApiRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<bool>verifyPinCode({required String pinCode}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (pinCode == '123456') {
      return true;
    } else {
      return false;
    }
  }
}