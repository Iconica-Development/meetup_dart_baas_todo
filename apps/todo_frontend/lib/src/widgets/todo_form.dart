import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:todo_frontend/src/providers/api_service.dart";
import "package:todo_models/todo_models.dart";

class TodoForm extends HookConsumerWidget {
  const TodoForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoText = useRef("");
    final formKey = useMemoized(GlobalKey<FormState>.new);

    Future<void> submit() async {
      final form = formKey.currentState;
      if (form == null || !form.validate()) return;

      form.save();

      final todoApiService = ref.read(todoApiServiceProvider);
      try {
        await todoApiService.createTodo(
          Todo(date: DateTime.now(), message: todoText.value, done: false),
        );
      } on TodoCreationFailedException catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          spacing: 8.0,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              minLines: 3,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (String? value) {
                final validator = TodoSerializer
                    .instance
                    .validators[TodoSerializer.keys.message];
                if (validator == null) return null;
                return switch (validator.validate(value)) {
                  null => null,
                  final String error => error,
                  _ => "Something went wrong whilst validating the input",
                };
              },
              onSaved: (value) => todoText.value = value ?? "",
            ),
            ElevatedButton(onPressed: submit, child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
