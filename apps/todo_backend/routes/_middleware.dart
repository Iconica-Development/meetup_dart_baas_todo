import "package:dart_frog/dart_frog.dart";

import "../src/providers/authentication.dart";
import "../src/providers/environment.dart";
import "../src/providers/firebase.dart";
import "../src/providers/firestore.dart";

Handler middleware(Handler handler) => handler
    .use(firestoreProvider)
    .use(firebaseProvider)
    .use(authenticationServiceProvider)
    .use(environmentProvider)
    .use(requestLogger());
