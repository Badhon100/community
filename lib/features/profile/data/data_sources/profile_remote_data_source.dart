import 'package:community/core/constants/api_constants.dart';
import 'package:community/core/errors/exceptions.dart';
import 'package:community/core/errors/failures.dart';
import 'package:community/core/network/api_service.dart';
import 'package:community/features/profile/domain/entities/profile_user_entity.dart';
import 'package:dio/dio.dart';
import '../models/profile_model.dart';
import '../../../../core/network/network_info.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileEntity> getProfile();
  Future<void> logout();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiService apiService;
  final NetworkInfo networkInfo;

  ProfileRemoteDataSourceImpl({
    required this.apiService,
    required this.networkInfo,
  });

  @override
  Future<ProfileEntity> getProfile() async {
    if (!await networkInfo.isConnected) {
      throw NetworkFailure('No internet connection');
    }
    try {
      final response = await apiService.get(
        ApiConstants.getUser,
      ); // your profile API
      return ProfileModel.fromJson(response.data);
    } on DioError catch (e) {
      throw ServerException(e.message!);
    }
  }

  @override
  Future<void> logout() async {
    if (!await networkInfo.isConnected) {
      throw NetworkFailure('No internet connection');
    }

    try {
      await apiService.post(ApiConstants.logout); // POST logout
    } on DioError catch (e) {
      throw ServerException(e.message ?? 'Logout failed');
    }
  }

}
