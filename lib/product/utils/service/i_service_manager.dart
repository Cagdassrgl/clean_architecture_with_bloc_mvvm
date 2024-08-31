import 'package:clean_architecture_with_bloc_mvvm/product/base/model/base_response_model.dart';

abstract class IServiceManager<T> {
  Future<BaseResponseModel<T>> get(String url);
}
