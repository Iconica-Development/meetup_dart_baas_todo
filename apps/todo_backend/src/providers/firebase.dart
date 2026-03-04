import "dart:io";

import "package:dart_firebase_admin/dart_firebase_admin.dart";
import "package:dart_frog/dart_frog.dart";

import "../models/environment.dart";

final firebaseProvider = provider<FirebaseAdminApp>(
  (context) => FirebaseAdminApp.initializeApp(
    context.read<Environment>().firebaseProjectId,
    Credential.fromServiceAccount(
      File("private/service-account.json"),
    ),
  ),
);
