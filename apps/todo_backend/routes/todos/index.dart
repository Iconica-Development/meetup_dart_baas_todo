import "dart:async";
import "dart:io";

import "package:dart_firebase_admin/firestore.dart";
import "package:dart_frog/dart_frog.dart";
import "package:dart_frog_utils/dart_frog_utils.dart";
import "package:todo_models/todo_models.dart";

Future<Response> onRequest(RequestContext context) async =>
    context.method(post: _createTodo);

FutureOr<Response> _createTodo(RequestContext context) async {
  final todo = await context.loadSerialized(TodoSerializer.instance);
  final firestore = context.read<Firestore>();

  final todoRef = await firestore
      .collection("todos")
      .withConverter(
        toFirestore: TodoSerializer.instance.toMap,
        fromFirestore: (snapshot) => TodoSerializer.instance.fromMap({
          TodoSerializer.keys.id: snapshot.id,
          ...snapshot.data(),
        }),
      )
      .add(todo);

  final createdTodo = (await todoRef.get()).data()!;

  return Response.json(
    statusCode: HttpStatus.created,
    body: createdTodo,
  );
}
