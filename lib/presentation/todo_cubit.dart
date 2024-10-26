import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/models/todo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todRepo;

  TodoCubit(this.todRepo) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todoList = await todRepo.getTodo();

    emit(todoList);
  }

  Future<void> addTodo(String text) async {
    final todo = Todo(id: DateTime.timestamp().microsecondsSinceEpoch, text: text);
    await todRepo.addTodo(todo);
    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await todRepo.deleteTodo(todo);
    loadTodos();
  }

  Future<void> toggleComplition(Todo todo) async {
    final updateTodo = todo.toggleComplition();
    await todRepo.updateTodo(updateTodo);
    loadTodos();
  }
}
