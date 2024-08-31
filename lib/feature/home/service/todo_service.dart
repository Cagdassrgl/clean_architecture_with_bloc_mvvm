import 'package:clean_architecture_with_bloc_mvvm/feature/home/model/todos.dart';
import 'package:clean_architecture_with_bloc_mvvm/product/base/model/base_response_model.dart';
import 'package:clean_architecture_with_bloc_mvvm/product/utils/service/i_service_manager.dart';

final class TodoService {
  final IServiceManager<List<dynamic>> _serviceManager;

  TodoService(this._serviceManager);

  final _baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  Future<BaseResponseModel<List<Todos>>> getTodos() async {
    try {
      final response = await _serviceManager.get(_baseUrl);
      if (response.data != null) {
        final todos = response.data?.map((e) => Todos.fromJson(e)).cast<Todos>().toList();
        return BaseResponseModel<List<Todos>>(data: todos, error: null);
      }
      return BaseResponseModel<List<Todos>>(data: null, error: response.error);
    } catch (e) {
      return BaseResponseModel<List<Todos>>(data: null, error: e.toString());
    }
  }
}
