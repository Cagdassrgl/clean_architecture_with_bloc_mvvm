import 'package:clean_architecture_with_bloc_mvvm/feature/home/model/todos.dart';
import 'package:clean_architecture_with_bloc_mvvm/feature/home/service/todo_service.dart';
import 'package:clean_architecture_with_bloc_mvvm/product/base/model/base_response_model.dart';
import 'package:clean_architecture_with_bloc_mvvm/product/utils/service/dio_service_manager.dart';
import 'package:clean_architecture_with_bloc_mvvm/product/utils/service/i_service_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TodosTest', () async {
    IServiceManager<List<dynamic>> service = DioServiceManager<List<dynamic>>();

    final response = await service.get('https://jsonplaceholder.typicode.com/todos');
    expect(response.data, isNotNull);

    final todos = response.data?.map((e) => Todos.fromJson(e)).cast<Todos>().toList();

    expect(todos, isA<List<Todos>>());
  });

  test('TodosService', () async {
    final service = TodoService(DioServiceManager());

    final response = await service.getTodos();
    expect(response.data, isNotNull);
    expect(response, isA<BaseResponseModel<List<Todos>>>());
  });
}
