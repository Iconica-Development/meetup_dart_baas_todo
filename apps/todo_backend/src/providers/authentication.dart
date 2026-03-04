import "dart:io";

import "package:dart_frog/dart_frog.dart";
import "package:googleapis/identitytoolkit/v1.dart";
import "package:googleapis_auth/auth_io.dart";

final authenticationServiceProvider = provider<Future<IdentityToolkitApi>>((
  context,
) async {
  final json = await File("private/service-account.json").readAsString();
  final accountCredentials = ServiceAccountCredentials.fromJson(json);
  const scopes = [IdentityToolkitApi.cloudPlatformScope];
  final client = await clientViaServiceAccount(accountCredentials, scopes);
  return IdentityToolkitApi(client);
});
