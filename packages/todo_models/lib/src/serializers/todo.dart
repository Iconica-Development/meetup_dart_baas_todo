import "package:dart_iconica_utilities/dart_iconica_utilities.dart";
import "package:todo_models/todo_models.dart";

DateTime? _maybeDateTime(dynamic value) => switch (value) {
  final String iso8601 => DateTime.parse(iso8601),
  final int fromEpoch => DateTime.fromMillisecondsSinceEpoch(fromEpoch),
  _ => null,
};

DateTime _dateTime(dynamic value) =>
    _maybeDateTime(value) ??
    (throw const FormatException("Not a valid datetime"));

class TodoSerializer extends Serializer<Todo> {
  TodoSerializer()
    : super(
        validators: _validators,
        fromMap: _fromMap,
        toMap: _toMap,
      );

  static final instance = TodoSerializer();

  static const keys = (
    id: "id",
    date: "date",
    message: "message",
    done: "done",
  );

  static final Map<String, ValueValidator> _validators = {
    keys.id: ValueValidator.string(optional: true),
    keys.date: ValueValidator(
      validator: (value) => switch (_maybeDateTime(value)) {
        DateTime() => null,
        null =>
          "Either provide a date string (iso8601) "
              "or milliseconds since epoch",
      },
    ),
    keys.message: ValueValidator.string(),
    keys.done: ValueValidator.bool(optional: true),
  };

  static Todo _fromMap(Map<String, dynamic> map) => Todo(
    id: map[keys.id] as String?,
    date: _dateTime(map[keys.date]),
    message: map[keys.message] as String,
    done: map[keys.done] as bool,
  );

  static Map<String, dynamic> _toMap(Todo object) => {
    keys.id: object.id,
    keys.date: object.date.toIso8601String(),
    keys.message: object.message,
    keys.done: object.done,
  };
}
