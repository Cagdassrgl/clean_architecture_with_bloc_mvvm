import 'package:bloc/bloc.dart';
import 'package:clean_architecture_with_bloc_mvvm/feature/home/model/todos.dart';
import 'package:clean_architecture_with_bloc_mvvm/feature/home/service/todo_service.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TodoService _service;

  HomeBloc(this._service) : super(HomeInitial()) {
    on<FetchTodosEvent>(_handleTodos);
  }

  void _handleTodos(FetchTodosEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    await _service.getTodos().then((response) {
      if (response.data == null) {
        emit(HomeFailure(response.error ?? 'No data found'));
        return;
      }
      emit(HomeSuccess(response.data!));
    }).catchError((error) {
      emit(HomeFailure(error.toString()));
    });
  }
}
