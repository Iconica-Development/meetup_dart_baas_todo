import "package:flutter/material.dart";
import "package:todo_frontend/src/widgets/todo_form.dart";
import "package:todo_frontend/src/widgets/todo_list.dart";

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("To-Do")),
    body: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.0,
        children: [
          TodoForm(),
          Divider(),
          Expanded(child: TodoList()),
        ],
      ),
    ),
  );
}
