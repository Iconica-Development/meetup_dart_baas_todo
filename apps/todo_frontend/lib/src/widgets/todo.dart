import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:todo_frontend/src/providers/api_service.dart";
import "package:todo_models/todo_models.dart";

class TodoItem extends ConsumerWidget {
  const TodoItem({
    required this.todo,
    super.key,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        spacing: 20.0,
        children: [
          Checkbox(value: todo.done, onChanged: (value) async {
            if (value == null || !value) return;
            await ref.read(todoApiServiceProvider).completeTodo(
              todo,
            );
          }),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(todo.message, style: switch(todo.done) {
                    true => const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.black54,
                    ),
                    false => null,
                  },),
                ),
                Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: Text(
                    todo.date.toIso8601String(),
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
