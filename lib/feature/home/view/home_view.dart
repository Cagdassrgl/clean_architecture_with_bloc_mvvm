import 'package:clean_architecture_with_bloc_mvvm/feature/home/bloc/home_bloc.dart';
import 'package:clean_architecture_with_bloc_mvvm/feature/home/service/todo_service.dart';
import 'package:clean_architecture_with_bloc_mvvm/product/utils/service/dio_service_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(TodoService(DioServiceManager()))..add(FetchTodosEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todos'),
        ),
        body: _blocBuilder(),
      ),
    );
  }

  BlocBuilder<HomeBloc, HomeState> _blocBuilder() {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is HomeState,
      builder: (context, state) {
        if (state is HomeLoading) {
          return _loading();
        } else if (state is HomeSuccess) {
          return _success(state);
        } else if (state is HomeFailure) {
          return _failure(state);
        }
        return const SizedBox();
      },
    );
  }

  Center _failure(HomeFailure state) {
    return Center(
      child: Text(state.error),
    );
  }

  ListView _success(HomeSuccess state) {
    return ListView.builder(
      itemCount: state.todos.length,
      itemBuilder: (context, index) {
        final todo = state.todos[index];
        return ListTile(
          title: Text(todo.title ?? ''),
          subtitle: Text(todo.completed == true ? 'Completed' : 'Not completed'),
        );
      },
    );
  }

  Center _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
