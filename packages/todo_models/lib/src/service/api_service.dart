import "dart:io";

import "package:dart_api_service/dart_api_service.dart";
import "package:todo_models/todo_models.dart";

class TodoApiService extends HttpApiService {
  TodoApiService({required super.baseUrl});

  final todoConverter = ModelJsonResponseConverter(
    deserialize: TodoSerializer.instance.fromMap,
    serialize: TodoSerializer.instance.toMap,
  );

  Endpoint<Todo, Todo> get _todoEndpoint =>
      endpoint("/todos").withConverter(todoConverter);

  Future<Todo> createTodo(Todo todo) async {
    try {
      final response = await _todoEndpoint.post(requestModel: todo);
      switch (response.result) {
        case final Todo todo:
          return todo;
        default:
          throw TodoCreationFailedException(
            "Received a wrong object ${response.statusCode}",
          );
      }
    } on ApiException catch (e) {
      throw TodoCreationFailedException(
        "Something went wrong while creating the todo:"
        " ${e.inner.statusCode} ${e.inner.body}",
      );
    } on SocketException catch (e) {
      throw TodoCreationFailedException(
        "Could not connect to the server: ${e.message}",
      );
    }
  }

  Future<Todo> completeTodo(Todo todo) async {
    final endpoint = _todoEndpoint
        .child("/${todo.id}")
        .withConverter(
          ModelJsonResponseConverter(
            deserialize: TodoSerializer.instance.fromMap,
            serialize: TodoUpdateSerializer.instance.toMap,
          ),
        );
    try {
      final response = await endpoint.post(
        requestModel: TodoUpdate(newMessage: null, newDone: true),
      );
      switch (response.result) {
        case final Todo todo:
          return todo;
        default:
          throw TodoCreationFailedException(
            "Received a wrong object ${response.statusCode}",
          );
      }
    } on ApiException catch (e) {
      throw TodoCreationFailedException(
        "Something went wrong while creating the todo:"
        " ${e.inner.statusCode} ${e.inner.body}",
      );
    } on SocketException catch (e) {
      throw TodoCreationFailedException(
        "Could not connect to the server: ${e.message}",
      );
    }
  }
}

class TodoCreationFailedException implements Exception {
  TodoCreationFailedException(this.message);
  final String message;

  @override
  String toString() => "TodoCreationFailedException: $message";
}
