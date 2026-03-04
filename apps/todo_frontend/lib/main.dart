import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:todo_frontend/src/screens/todo.dart";
import "package:todo_frontend/src/utils/init.dart";

void main() async {
  await init();
  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
    home: TodoScreen(),
  );
}
