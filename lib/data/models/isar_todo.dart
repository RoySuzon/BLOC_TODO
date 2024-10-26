import 'package:isar/isar.dart';
import 'package:todo_bloc/domain/models/todo.dart';
part 'isar_todo.g.dart';

@collection
class IsarTodo {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isComplete;

  Todo toDomain() => Todo(id: id, text: text, isComplete: isComplete);

  static IsarTodo fromDomain(Todo todo) => IsarTodo()
    ..id = todo.id
    ..text = todo.text
    ..isComplete = todo.isComplete;
}
