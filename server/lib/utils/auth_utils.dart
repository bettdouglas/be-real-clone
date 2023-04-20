import 'package:dbcrypt/dbcrypt.dart';
import 'package:jose/jose.dart';
import 'package:server/database/models.dart';
import 'package:server/utils/dotenv.dart';

String createJwt(
  BaseUserView user, {
  Duration expiry = const Duration(days: 2),
}) {
  final secretKey = dotEnv.getOrElse(
    'SECRET_KEY',
    () => throw 'SECRET_KEY not defined',
  );
  final claims = JsonWebTokenClaims.fromJson({
    "exp": expiry.inSeconds,
    "iss": "bereal-clone.com",
  });
  final builder = JsonWebSignatureBuilder();
  builder.addRecipient(
    JsonWebKey.fromJson(
      {
        "k": secretKey,
        "kty": 'oct',
      },
    ),
    algorithm: 'HS256',
  );
  builder.jsonContent = {
    'id': user.id,
    'username': user.username,
    'phone': user.phone,
  };
  final jwt = builder.build();
  return jwt.toCompactSerialization();
}

/// this will verify the JWT and return the claims or throw an exception.
/// Try catch will be needed when calling this method.
Future<Map<String, dynamic>> decodeJwt(String token) async {
  final secretKey = dotEnv.getOrElse(
    'SECRET_KEY',
    () => throw 'SECRET_KEY not defined',
  );
  final unverified = JsonWebToken.unverified(token);
  final keyStore = JsonWebKeyStore()
    ..addKey(JsonWebKey.fromJson({
      "kty": "oct",
      "k": secretKey,
    }));
  final verified = await unverified.verify(keyStore);
  if (verified) {
    final claims = unverified.claims.toJson();
    return claims;
  } else {
    throw InvalidTokenException('Invalid token');
  }
}

String hashPassword(String password) {
  return DBCrypt().hashpw(password, DBCrypt().gensalt());
}

bool checkPassword(String password, String passwordHash) {
  return DBCrypt().checkpw(password, passwordHash);
}

class InvalidTokenException implements Exception {
  final String message;
  InvalidTokenException(this.message);

  @override
  String toString() {
    return 'InvalidTokenException($message)';
  }
}
