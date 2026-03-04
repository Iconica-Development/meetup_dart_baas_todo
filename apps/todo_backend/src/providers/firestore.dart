import "package:dart_firebase_admin/dart_firebase_admin.dart";
import "package:dart_firebase_admin/firestore.dart";
import "package:dart_frog/dart_frog.dart";
import "package:todo_models/todo_models.dart";

final firestoreProvider = provider<TodoRepository>(
  (context) => TodoRepository(Firestore(context.read<FirebaseAdminApp>())),
);

extension type TodoRepository(Firestore firestore) {
   CollectionReference<Todo> get todos => firestore
      .collection("todos")
      .withConverter(
        toFirestore: TodoSerializer.instance.toMap,
        fromFirestore: (snapshot) => TodoSerializer.instance.fromMap({
          TodoSerializer.keys.id: snapshot.id,
          ...snapshot.data(),
        }),
      );

}
