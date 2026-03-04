import "dart:async";
import "dart:io";

import "package:dart_frog/dart_frog.dart";
import "package:dart_frog_utils/dart_frog_utils.dart";
import "package:todo_models/todo_models.dart";

import "../../src/providers/firestore.dart";

Future<Response> onRequest(RequestContext context) async =>
    context.method(post: _createTodo);

FutureOr<Response> _createTodo(RequestContext context) async {
  final todo = await context.loadSerialized(TodoSerializer.instance);
  final todoRepository = context.read<TodoRepository>();

  final todoRef = await todoRepository.todos.add(todo);

  final createdTodo = (await todoRef.get()).data()!;

  return Response.json(
    statusCode: HttpStatus.created,
    body: createdTodo.serializer.serialize(),
  );
}
