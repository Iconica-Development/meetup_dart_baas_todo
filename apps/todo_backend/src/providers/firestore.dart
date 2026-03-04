import "package:dart_firebase_admin/dart_firebase_admin.dart";
import "package:dart_firebase_admin/firestore.dart";
import "package:dart_frog/dart_frog.dart";

final firestoreProvider = provider<Firestore>(
  (context) => Firestore(context.read<FirebaseAdminApp>()),
);
