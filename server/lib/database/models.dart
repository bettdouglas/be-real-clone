import 'package:stormberry/stormberry.dart';

part 'models.schema.dart';

@Model(
  tableName: 'accounts',
)
abstract class User {
  // the firebase id
  @PrimaryKey()
  String get id;

  String get username;

  String? get phone;

  DateTime get createdAt;

  String get passwordHash;
}

class UserNameQuery extends Query<UserView?, String> {
  @override
  Future<UserView?> apply(Database db, String params) async {
    final query = 'SELECT "accounts".*'
        'FROM "accounts"'
        'WHERE "accounts".username = @username';
    final result = await db.query(
      query,
      {'username': params},
    );

    if (result.isEmpty) {
      return null;
    }
    return UserViewQueryable().decode(TypedMap(result.first.toColumnMap()));
  }
}
