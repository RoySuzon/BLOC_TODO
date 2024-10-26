import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';
import 'package:todo_bloc/presentation/todo_cubit.dart';
import 'package:todo_bloc/presentation/todo_view.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key, required this.todRepo});

  final TodoRepo todRepo;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(todRepo),
      child: const TodoView(),
    );
  }
}