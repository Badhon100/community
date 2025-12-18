import 'package:community/features/authenticaction/data/models/auth_user_model.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_service.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<AuthUserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        ApiConstants.login,
        data: {"email": email, "password": password},
      );

      return AuthUserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Login failed');
    }
  }
}
