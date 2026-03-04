import "package:dart_frog/dart_frog.dart";
import "package:dotenv/dotenv.dart";

import "../models/environment.dart";

final environmentProvider = provider(
  (context) => Environment.fromDotEnv(
    DotEnv(
      includePlatformEnvironment: true,
      quiet: true,
    )..load(),
  ),
);
