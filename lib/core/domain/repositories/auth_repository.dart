import '../../../features/authentication/account/login/models/login_form_validation_model.dart';
import '../../api/resource/resource.dart';
import '../entities/oauth_token_entity.dart';

abstract class AuthRepository {
  Future<Result<OauthTokenEntity>> loginUser(
      LoginRequestModel loginRequestModel);
  Future<Result<OauthTokenEntity>> fetchCachedToken();
  Future<Result<OauthTokenEntity>> signUpUser(
      String firstName, String lastName, String emailAddress, String password);
  Future<Result<bool>> setUpNewPassword(
      String emailAddress, String password, String securityCode);
  Future<Result<bool>> requestForgotPassword(String emailAddress);
  Future<void> logout();
}
