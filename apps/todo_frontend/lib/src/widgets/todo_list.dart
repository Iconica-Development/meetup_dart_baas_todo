import "package:flutter/material.dart";
import "package:todo_frontend/src/widgets/todo.dart";
import "package:todo_models/todo_models.dart";

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    children: List.generate(
      100,
      (index) => TodoItem(
        todo: Todo(
          id: "someid",
          date: DateTime.now().subtract(Duration(days: index)),
          message: "Todo No ${100 - index}",
          done: false,
        ),
      ),
    ),
  );
}
