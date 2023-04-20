import 'package:server/database/models.dart';
import 'package:server/utils/auth_utils.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart';

void main() {
  final dotEnv = DotEnv(includePlatformEnvironment: true)..load(['.env']);

  late String secretKey;
  late UserView user;

  setUpAll(() {
    secretKey = dotEnv.getOrElse(
      'SECRET_KEY',
      () => throw 'SECRET_KEY not defined',
    );
    user = UserView(
      createdAt: DateTime.now(),
      id: '1',
      passwordHash: 'hashed',
      username: 'user1',
    );
  });

  test('can create jwt', () async {
    final jwt = createJwt(user);
    expect(jwt, isA<String>());
  });

  test('can decode jwt', () async {
    final jwt = createJwt(user);
    final claims = await decodeJwt(jwt);
    expect(claims, isA<Map>());
    expect(claims['id'], equals(user.id));
    expect(claims['username'], equals(user.username));
    expect(claims['phone'], equals(user.phone));
  });
}
