import 'package:isar/isar.dart';
import 'package:todo_bloc/data/models/isar_todo.dart';
import 'package:todo_bloc/domain/models/todo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar isar;

  IsarTodoRepo(this.isar);

  //get Todos
  @override
  Future<List<Todo>> getTodo() async {
    final todos = await isar.isarTodos.where().findAll();
    return todos.map((e) => e.toDomain()).toList();
  }

  //add new Todo

  @override
  Future<void> addTodo(Todo todo) async {
    final isarTodo = IsarTodo.fromDomain(todo);
    await isar.writeTxn(() => isar.isarTodos.put(isarTodo));
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await isar.writeTxn(() => isar.isarTodos.delete(todo.id));
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final isarTodo = IsarTodo.fromDomain(todo);
    await isar.writeTxn(() => isar.isarTodos.put(isarTodo));
  }
}
