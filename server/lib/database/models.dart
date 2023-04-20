import 'package:stormberry/stormberry.dart';

part 'models.schema.dart';

@Model(
  tableName: 'accounts',
  views: [#Full, #Reduced, #Base],
)
abstract class User {
  // the firebase id
  @PrimaryKey()
  String get id;

  String get username;

  @HiddenIn(#Reduced)
  String? get phone;

  DateTime get createdAt;

  @HiddenIn(#Reduced)
  @HiddenIn(#Full)
  String get passwordHash;

  @HiddenIn(#Reduced)
  @HiddenIn(#Base)
  @ViewedIn(#Full, as: #Base)
  List<Photo> get photos;
}

@Model(
  tableName: 'photos',
  views: [#Base, #Complete],
)
abstract class Photo {
  @PrimaryKey()
  String get id;

  String get url;

  String get description;

  DateTime get createdAt;

  @ViewedIn(#Base, as: #Reduced)
  @ViewedIn(#Complete, as: #Reduced)
  User get creator;

  @ViewedIn(#Base, as: #Base)
  @ViewedIn(#Complete, as: #Base)
  List<Like> get likes;
}

@Model(
  views: [#Base],
)
abstract class Like {
  @PrimaryKey()
  int get id;

  DateTime get createdAt;

  @ViewedIn(#Base, as: #Reduced)
  User get user;
}

class UserNameQuery extends Query<BaseUserView?, String> {
  @override
  Future<BaseUserView?> apply(Database db, String params) async {
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
    return BaseUserViewQueryable().decode(TypedMap(result.first.toColumnMap()));
  }
}
