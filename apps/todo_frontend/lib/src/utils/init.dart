import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:todo_frontend/firebase_options.dart";

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
