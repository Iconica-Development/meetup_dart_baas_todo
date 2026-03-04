import "package:dart_iconica_utilities/dart_iconica_utilities.dart";
import "package:todo_models/todo_models.dart";

class TodoUpdateSerializer extends Serializer<TodoUpdate> {
  TodoUpdateSerializer()
    : super(
        validators: _validators,
        fromMap: _fromMap,
        toMap: _toMap,
      );

  static final instance = TodoUpdateSerializer();

  static const keys = (
    newMessage: "newMessage",
    newDone: "newDone",
  );

  static final Map<String, ValueValidator> _validators = {
    keys.newMessage: ValueValidator.string(optional: true),
    keys.newDone: ValueValidator.bool(optional: true),
  };

  static TodoUpdate _fromMap(Map<String, dynamic> map) => TodoUpdate(
    newMessage: map[keys.newMessage] as String?,
    newDone: map[keys.newDone] as bool?,
  );

  static Map<String, dynamic> _toMap(TodoUpdate object) => {
    keys.newMessage: object.newMessage,
    keys.newDone: object.newDone,
  };
}
