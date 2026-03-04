import "package:dotenv/dotenv.dart";

class Environment {
  const Environment({
    required this.firebaseApiKey,
    required this.firebaseProjectId,
  });

  factory Environment.fromDotEnv(DotEnv dotEnv) => Environment(
    firebaseApiKey: dotEnv["FIREBASE_API_KEY"] ?? "",
    firebaseProjectId: dotEnv["FIREBASE_PROJECT_ID"] ?? "",
  );

  final String firebaseApiKey;
  final String firebaseProjectId;
}
