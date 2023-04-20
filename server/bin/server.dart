import 'package:dotenv/dotenv.dart';
import 'package:server/database/models.dart';
import 'package:stormberry/stormberry.dart';

void main(List<String> arguments) async {
  final dotEnv = DotEnv(includePlatformEnvironment: true)..load(['.env']);

  final database = Database(
    database: dotEnv.getOrElse(
      'POSTGRES_DB',
      () => throw Exception('POSTGRES_DB not defined'),
    ),
    host: dotEnv.getOrElse(
      'POSTGRES_DB',
      () => throw Exception('POSTGRES_DB not defined'),
    ),
    port: int.parse(dotEnv.getOrElse(
      'POSTGRES_DB',
      () => throw Exception('POSTGRES_DB not defined'),
    )),
    useSSL: false,
    password: dotEnv.getOrElse(
      'POSTGRES_DB',
      () => throw Exception('POSTGRES_DB not defined'),
    ),
  );
  // Insert
  await database.users.insertOne(
    UserInsertRequest(
      id: 'id',
      username: 'user1',
      createdAt: DateTime.now(),
      passwordHash: 'passwordHash',
    ),
  );
  // query
  final gotUser = await database.users.queryUser('id');
  if (gotUser != null) {
    // user found
    print(gotUser.id);
    print(gotUser.username);
    print(gotUser.createdAt);
    print(gotUser.phone);
  }

  /// Update one
  await database.users.updateOne(
    UserUpdateRequest(id: 'id', phone: '+254345678'),
  );
  final updatedUser = await database.users.queryUser('id');

// delete
  await database.users.deleteOne('id');
}
