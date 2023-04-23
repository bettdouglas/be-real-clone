import 'package:grpc/grpc.dart';
import 'package:server/utils/auth_utils.dart';

Future<GrpcError?> authInterceptor(
  ServiceCall call,
  ServiceMethod method,
) async {
  final openMethods = [
    '/bereal.UserService/Login',
    '/bereal.UserService/CreateUser',
  ];
  final metadata = call.clientMetadata ?? {};
  final methodName = metadata[':path'];
  if (openMethods.contains(methodName)) {
    return null;
  }
  final token = metadata['authorization'];
  if (token == null) {
    return GrpcError.unauthenticated('Token not found');
  }
  try {
    final claims = await decodeJwt(token);
    print(claims);
    call.clientMetadata!.addAll(
      claims.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
    return null;
  } on InvalidTokenException {
    return GrpcError.unauthenticated();
  } catch (e) {
    return GrpcError.unknown(e.toString());
  }
}
