import "package:cloud_firestore/cloud_firestore.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:todo_models/todo_models.dart";

final todosProvider = StreamProvider<List<Todo>>(
  (ref) => FirebaseFirestore.instance
      .collection("todos")
      .withConverter<Todo>(
        toFirestore: (todo, _) => throw UnimplementedError(),
        fromFirestore: (snapshot, _) => TodoSerializer.instance.fromMap({
          ...snapshot.data()!,
          TodoSerializer.keys.id: snapshot.id,
        }),
      )
      .snapshots()
      .map(
        (documents) =>
            documents.docs.map((doc) => doc.data()).toList().reversed.toList(),
      ),
);
