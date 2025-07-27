import 'package:dio/dio.dart';
import 'package:firebase_movies_app/core/const/erros_const.dart';
import 'package:firebase_movies_app/core/service/dot_env_service.dart';
import 'package:firebase_movies_app/data/models/api_response_model.dart';
import 'package:firebase_movies_app/data/repositories/api_repository/i_api_repository.dart';

class DioRepositoryImpl implements IApiRepository {
  final Dio _dio;
  DioRepositoryImpl(this._dio);

  @override
  Future<(String?, ApiResponseModel<T>?)> get<T>(String endPoint) async{
    try {
      final response = await _dio.get(
        endPoint,
        options: Options(
          headers: {'Authorization': 'Bearer ${DotEnvService.getApiToken}'}
        )
      );
      return (null, ApiResponseModel<T>(
        data: response.data as T,
        statusMessage: response.statusMessage,
      ));
    } on DioException catch (e) {
      final errorMessage = e.message ?? ErrorsConst.API_DEFAULT_ERROR;
      return (errorMessage, null);
    }
  }
}