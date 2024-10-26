import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/models/todo.dart';
import 'package:todo_bloc/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(hintText: "todo title is here ..."),
                    controller: textController,
                  )
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      if (textController.text != "") {
                        todoCubit.addTodo(textController.text.trim()).then(
                              (value) => Navigator.pop(context),
                            );
                      }
                    },
                    child: const Text('Submit')),
              ],
            ));
  }

  void confirmDeleteBox(BuildContext context, VoidCallback onTap) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text('Do you want to delete this item')],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                TextButton(onPressed: onTap, child: const Text('Confirm')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoBox(context),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          final bloc = context.read<TodoCubit>();

          return ListView.builder(
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                leading: Checkbox(
                  value: todo.isComplete,
                  onChanged: (value) => bloc.toggleComplition(todo),
                ),
                trailing: IconButton(
                    onPressed: () => confirmDeleteBox(
                          context,
                          () => bloc.deleteTodo(todo).whenComplete(
                                () => Navigator.pop(context),
                              ),
                        ),
                    icon: const Icon(Icons.close)),
                title: Text(todo.text),
              );
            },
            itemCount: todos.length,
          );
        },
      ),
    );
  }
}
