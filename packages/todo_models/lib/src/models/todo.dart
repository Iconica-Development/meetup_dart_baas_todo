import "package:dart_iconica_utilities/dart_iconica_utilities.dart";
import "package:todo_models/src/serializers/todo.dart";

class Todo {
  const Todo({
    required this.date,
    required this.message,
    required this.done,
    this.id,
  });

  final String? id;
  final DateTime date;
  final String message;
  final bool done;

  Serializer<Todo> get serializer => TodoSerializer.instance.withObject(this);
}
