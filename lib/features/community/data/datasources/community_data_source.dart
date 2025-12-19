import 'package:community/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import '../models/community_model.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_service.dart';

abstract class CommunityRemoteDataSource {
  Future<List<CommunityModel>> fetchCommunities({
    required int page,
    required int limit,
    String? search,
  });
}

class CommunityRemoteDataSourceImpl implements CommunityRemoteDataSource {
  final ApiService apiService;

  CommunityRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<CommunityModel>> fetchCommunities({
    required int page,
    required int limit,
    String? search,
  }) async {
    try {
      final response = await apiService.get(
        ApiConstants.getCommunityList,
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null && search.isNotEmpty) 'str': search,
        },
      );

      final data = response.data['data'] as List;
      return data.map((e) => CommunityModel.fromJson(e)).toList();
    } on DioError catch (e) {
      throw ServerException(e.message!);
    }
  }
}
