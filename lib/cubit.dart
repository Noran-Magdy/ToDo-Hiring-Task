// lib/todo_cubit.dart
// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String task;

  const Todo({required this.id, required this.task});

  @override
  List<Object> get props => [id, task];
}

class TodoState extends Equatable {
  final List<Todo> todos;
  final String? selectedTodoId;

  const TodoState({this.todos = const [], this.selectedTodoId});

  @override
  List<Object?> get props => [todos, selectedTodoId];

  TodoState copyWith({List<Todo>? todos, String? selectedTodoId}) {
    return TodoState(
      todos: todos ?? this.todos,
      selectedTodoId: selectedTodoId ?? this.selectedTodoId,
    );
  }
}

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoState());

  void addTodo(String task) {
    final newTodo = Todo(id: Random().nextDouble().toString(), task: task);

    final updatedList = List<Todo>.from(state.todos)..add(newTodo);
  }

  void deleteTodo(String id) {
    final updatedList = state.todos.where((todo) => todo.id != id).toList();

    emit(state.copyWith(todos: updatedList));
  }

  void selectTodo(String id) {
    emit(state.copyWith(selectedTodoId: id));
  }
}
