import "dart:io";

import "package:dart_frog/dart_frog.dart";
import "package:dart_frog_utils/dart_frog_utils.dart";
import "package:todo_models/todo_models.dart";

import "../../../src/providers/firestore.dart";

Future<Response> onRequest(RequestContext context, String todoId) async =>
    context.method(
      post: (context) => _updateTodo(context, todoId),
    );

Future<Response> _updateTodo(RequestContext context, String todoId) async {
  final updateTodo = await context.loadSerialized(
    TodoUpdateSerializer.instance,
  );

  final repository = context.read<TodoRepository>();
  final todoRef = repository.todos.doc(todoId);
  await todoRef.update({
    if (updateTodo.newMessage != null)
      TodoSerializer.keys.message: updateTodo.newMessage,
    if (updateTodo.newDone != null)
      TodoSerializer.keys.done: updateTodo.newDone,
  });

  return Response.json(
    statusCode: HttpStatus.ok,
    body: await todoRef.get().then(
      (snapshot) => snapshot.data()!.serializer.serialize(),
    ),
  );
}
