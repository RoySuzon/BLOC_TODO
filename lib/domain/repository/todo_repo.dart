import 'package:todo_bloc/domain/models/todo.dart';

abstract class TodoRepo {
  //get todoList
  Future<List<Todo>> getTodo();

  //add new todo
  Future<void> addTodo(Todo todo);

  //update todo
  Future<void> updateTodo(Todo todo);

  //delet todo
  Future<void> deleteTodo(Todo todo);
}
