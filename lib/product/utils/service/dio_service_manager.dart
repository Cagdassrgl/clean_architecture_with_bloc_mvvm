import 'dart:io';

import 'package:clean_architecture_with_bloc_mvvm/product/base/model/base_response_model.dart';
import 'package:clean_architecture_with_bloc_mvvm/product/utils/service/i_service_manager.dart';
import 'package:dio/dio.dart';

final class DioServiceManager<T> extends IServiceManager<T> {
  late final Dio _dio;

  DioServiceManager() {
    _dio = Dio();
  }

  @override
  Future<BaseResponseModel<T>> get(String url) async {
    try {
      final response = await _dio.get(url);

      if (response.statusCode == HttpStatus.ok) {
        return BaseResponseModel<T>(data: response.data, error: null);
      }
      return BaseResponseModel<T>(data: null, error: response.statusMessage);
    } on DioException catch (e) {
      return BaseResponseModel<T>(data: null, error: e.message);
    }
  }
}
