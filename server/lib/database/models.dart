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
