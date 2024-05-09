import '../../../../features/authentication/account/login/models/login_form_validation_model.dart';
import '../../../api/clients/rest_client/auth_api_client/auth_api_client.dart';
import '../../../api/exceptions/exception_handler.dart';
import '../../../api/models/empty_success_response/empty_success_response.dart';
import '../../../api/models/outh_token_data/outh_token_data.dart';

abstract class AuthRemoteDataSource {
  Future<OauthTokenData> loginUser(LoginRequestModel loginRequestModel);
  Future<OauthTokenData> refreshToken(
      String refreshToken, String grantType, String scopes);
  Future<OauthTokenData> signUpUser(
      String firstName, String lastName, String email, String password);
  Future<EmptySuccessResponse> requestForgotPassword(String emailAddress);
  Future<EmptySuccessResponse> setNewPassword(
      String emailAddress, String password, String securityCode);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required AuthApiClient authApiClient})
      : _authApiClient = authApiClient;

  final AuthApiClient _authApiClient;

  @override
  Future<OauthTokenData> loginUser(LoginRequestModel loginRequestModel) async {
    try {
      final json = <String, dynamic>{
        'email': loginRequestModel.email,
        'password': loginRequestModel.password
      };
      final loginData = (await _authApiClient.loginUser(json)).data;
      return loginData;
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  @override
  Future<OauthTokenData> refreshToken(
      String refreshToken, String grantType, String scopes) async {
    try {
      return await _authApiClient.refreshToken(refreshToken, grantType, scopes);
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  @override
  Future<OauthTokenData> signUpUser(
      String firstName, String lastName, String email, String password) async {
    // await Future.delayed(
    //   const Duration(seconds: 2),
    // );
    // return OauthTokenData('1123123', '131123', '1');

    try {
      return (await _authApiClient.signUp(firstName, lastName, email, password))
          .data;
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  @override
  Future<EmptySuccessResponse> requestForgotPassword(
      String emailAddress) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    return EmptySuccessResponse();
    // try {
    //   return await _authApiClient.requestForgotPassword(emailAddress);
    // } catch (e) {
    //   throw ExceptionHandler.handleException(e);
    // }
  }

  @override
  Future<EmptySuccessResponse> setNewPassword(
      String emailAddress, String password, String securityCode) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    return EmptySuccessResponse();
    // try {
    //   return await _authApiClient.requestNewPasswordSet(
    //       emailAddress, password, securityCode);
    // } catch (e) {
    //   throw ExceptionHandler.handleException(e);
    // }
  }
}
