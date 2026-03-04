import "package:dart_frog/dart_frog.dart";
import "package:dart_frog_utils/dart_frog_utils.dart";
import "package:googleapis/identitytoolkit/v1.dart";

Future<Response> onRequest(RequestContext context) async => context.method(
  get: test,
);

Future<Response> test(RequestContext context) async {
  final auth = await context.read<Future<IdentityToolkitApi>>();
  final request = GoogleCloudIdentitytoolkitV1SignInWithPasswordRequest(
    email: "",
  );
  final response = await auth.accounts.signInWithPassword(request);

  return Response.json(body: response.toJson());
}
