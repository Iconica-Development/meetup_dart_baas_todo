import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:todo_models/todo_models.dart";

final todoApiServiceProvider = Provider(
  (ref) => TodoApiService(
    baseUrl: Uri.parse("http://localhost:8080"),
  ),
);
