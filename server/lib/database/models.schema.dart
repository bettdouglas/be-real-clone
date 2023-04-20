// ignore_for_file: annotate_overrides

part of 'models.dart';

extension ModelsRepositories on Database {
  UserRepository get users => UserRepository._(this);
}

abstract class UserRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<UserInsertRequest>,
        ModelRepositoryUpdate<UserUpdateRequest>,
        ModelRepositoryDelete<String> {
  factory UserRepository._(Database db) = _UserRepository;

  Future<UserView?> queryUser(String id);
  Future<List<UserView>> queryUsers([QueryParams? params]);
}

class _UserRepository extends BaseRepository
    with
        RepositoryInsertMixin<UserInsertRequest>,
        RepositoryUpdateMixin<UserUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements UserRepository {
  _UserRepository(super.db) : super(tableName: 'accounts', keyName: 'id');

  @override
  Future<UserView?> queryUser(String id) {
    return queryOne(id, UserViewQueryable());
  }

  @override
  Future<List<UserView>> queryUsers([QueryParams? params]) {
    return queryMany(UserViewQueryable(), params);
  }

  @override
  Future<void> insert(List<UserInsertRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'INSERT INTO "accounts" ( "id", "username", "phone", "created_at", "password_hash" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.id)}:text, ${values.add(r.username)}:text, ${values.add(r.phone)}:text, ${values.add(r.createdAt)}:timestamp, ${values.add(r.passwordHash)}:text )').join(', ')}\n',
      values.values,
    );
  }

  @override
  Future<void> update(List<UserUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "accounts"\n'
      'SET "username" = COALESCE(UPDATED."username", "accounts"."username"), "phone" = COALESCE(UPDATED."phone", "accounts"."phone"), "created_at" = COALESCE(UPDATED."created_at", "accounts"."created_at"), "password_hash" = COALESCE(UPDATED."password_hash", "accounts"."password_hash")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:text::text, ${values.add(r.username)}:text::text, ${values.add(r.phone)}:text::text, ${values.add(r.createdAt)}:timestamp::timestamp, ${values.add(r.passwordHash)}:text::text )').join(', ')} )\n'
      'AS UPDATED("id", "username", "phone", "created_at", "password_hash")\n'
      'WHERE "accounts"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class UserInsertRequest {
  UserInsertRequest({
    required this.id,
    required this.username,
    this.phone,
    required this.createdAt,
    required this.passwordHash,
  });

  final String id;
  final String username;
  final String? phone;
  final DateTime createdAt;
  final String passwordHash;
}

class UserUpdateRequest {
  UserUpdateRequest({
    required this.id,
    this.username,
    this.phone,
    this.createdAt,
    this.passwordHash,
  });

  final String id;
  final String? username;
  final String? phone;
  final DateTime? createdAt;
  final String? passwordHash;
}

class UserViewQueryable extends KeyedViewQueryable<UserView, String> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(String key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "accounts".*'
      'FROM "accounts"';

  @override
  String get tableAlias => 'accounts';

  @override
  UserView decode(TypedMap map) => UserView(
      id: map.get('id'),
      username: map.get('username'),
      phone: map.getOpt('phone'),
      createdAt: map.get('created_at'),
      passwordHash: map.get('password_hash'));
}

class UserView {
  UserView({
    required this.id,
    required this.username,
    this.phone,
    required this.createdAt,
    required this.passwordHash,
  });

  final String id;
  final String username;
  final String? phone;
  final DateTime createdAt;
  final String passwordHash;
}
