import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:todo_frontend/src/providers/todos.dart";
import "package:todo_frontend/src/widgets/todo.dart";
import "package:todo_models/todo_models.dart";

class TodoList extends HookConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);

    return switch (todos) {
      AsyncLoading<List<Todo>>() => const Center(
        child: CircularProgressIndicator(),
      ),
      AsyncError<List<Todo>>() => const Center(
        child: Text("An error occurred whilst fetching the todos"),
      ),
      AsyncData<List<Todo>>(:final value) => ListView.builder(
        itemCount: value.length,
        itemBuilder: (context, index) => TodoItem(todo: value[index]),
      ),
    };
  }
}
