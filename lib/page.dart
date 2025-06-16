// lib/todo_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/cubit.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Buggy Todo List')),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state.todos.isEmpty) {
            return Container();
          }

          return Column(
            children: [
              ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  final todo = state.todos[index];
                  final isSelected = state.selectedTodoId == todo.id;

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    color: isSelected ? Colors.blue.shade100 : Colors.white,
                    child: ListTile(
                      onTap: () =>
                          context.read<TodoCubit>().selectTodo(todo.id),
                      title: Text(todo.task),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected)
                            const Icon(Icons.check, color: Colors.green),
                          const SizedBox(width: 8),

                          Icon(Icons.delete, color: Colors.red.shade400),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Add New Task'),
                content: TextField(
                  controller: textController,
                  decoration: const InputDecoration(labelText: 'Task name'),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        BlocProvider.of<TodoCubit>(
                          context,
                        ).addTodo(textController.text);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
