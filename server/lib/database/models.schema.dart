// ignore_for_file: annotate_overrides

part of 'models.dart';

extension ModelsRepositories on Database {
  UserRepository get users => UserRepository._(this);
  PhotoRepository get photos => PhotoRepository._(this);
  LikeRepository get likes => LikeRepository._(this);
}

abstract class UserRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<UserInsertRequest>,
        ModelRepositoryUpdate<UserUpdateRequest>,
        ModelRepositoryDelete<String> {
  factory UserRepository._(Database db) = _UserRepository;

  Future<FullUserView?> queryFullView(String id);
  Future<List<FullUserView>> queryFullViews([QueryParams? params]);
  Future<ReducedUserView?> queryReducedView(String id);
  Future<List<ReducedUserView>> queryReducedViews([QueryParams? params]);
  Future<BaseUserView?> queryBaseView(String id);
  Future<List<BaseUserView>> queryBaseViews([QueryParams? params]);
}

class _UserRepository extends BaseRepository
    with
        RepositoryInsertMixin<UserInsertRequest>,
        RepositoryUpdateMixin<UserUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements UserRepository {
  _UserRepository(super.db) : super(tableName: 'accounts', keyName: 'id');

  @override
  Future<FullUserView?> queryFullView(String id) {
    return queryOne(id, FullUserViewQueryable());
  }

  @override
  Future<List<FullUserView>> queryFullViews([QueryParams? params]) {
    return queryMany(FullUserViewQueryable(), params);
  }

  @override
  Future<ReducedUserView?> queryReducedView(String id) {
    return queryOne(id, ReducedUserViewQueryable());
  }

  @override
  Future<List<ReducedUserView>> queryReducedViews([QueryParams? params]) {
    return queryMany(ReducedUserViewQueryable(), params);
  }

  @override
  Future<BaseUserView?> queryBaseView(String id) {
    return queryOne(id, BaseUserViewQueryable());
  }

  @override
  Future<List<BaseUserView>> queryBaseViews([QueryParams? params]) {
    return queryMany(BaseUserViewQueryable(), params);
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

abstract class PhotoRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<PhotoInsertRequest>,
        ModelRepositoryUpdate<PhotoUpdateRequest>,
        ModelRepositoryDelete<String> {
  factory PhotoRepository._(Database db) = _PhotoRepository;

  Future<BasePhotoView?> queryBaseView(String id);
  Future<List<BasePhotoView>> queryBaseViews([QueryParams? params]);
  Future<CompletePhotoView?> queryCompleteView(String id);
  Future<List<CompletePhotoView>> queryCompleteViews([QueryParams? params]);
}

class _PhotoRepository extends BaseRepository
    with
        RepositoryInsertMixin<PhotoInsertRequest>,
        RepositoryUpdateMixin<PhotoUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements PhotoRepository {
  _PhotoRepository(super.db) : super(tableName: 'photos', keyName: 'id');

  @override
  Future<BasePhotoView?> queryBaseView(String id) {
    return queryOne(id, BasePhotoViewQueryable());
  }

  @override
  Future<List<BasePhotoView>> queryBaseViews([QueryParams? params]) {
    return queryMany(BasePhotoViewQueryable(), params);
  }

  @override
  Future<CompletePhotoView?> queryCompleteView(String id) {
    return queryOne(id, CompletePhotoViewQueryable());
  }

  @override
  Future<List<CompletePhotoView>> queryCompleteViews([QueryParams? params]) {
    return queryMany(CompletePhotoViewQueryable(), params);
  }

  @override
  Future<void> insert(List<PhotoInsertRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'INSERT INTO "photos" ( "id", "url", "description", "created_at", "creator_id" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.id)}:text, ${values.add(r.url)}:text, ${values.add(r.description)}:text, ${values.add(r.createdAt)}:timestamp, ${values.add(r.creatorId)}:text )').join(', ')}\n',
      values.values,
    );
  }

  @override
  Future<void> update(List<PhotoUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "photos"\n'
      'SET "url" = COALESCE(UPDATED."url", "photos"."url"), "description" = COALESCE(UPDATED."description", "photos"."description"), "created_at" = COALESCE(UPDATED."created_at", "photos"."created_at"), "creator_id" = COALESCE(UPDATED."creator_id", "photos"."creator_id")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:text::text, ${values.add(r.url)}:text::text, ${values.add(r.description)}:text::text, ${values.add(r.createdAt)}:timestamp::timestamp, ${values.add(r.creatorId)}:text::text )').join(', ')} )\n'
      'AS UPDATED("id", "url", "description", "created_at", "creator_id")\n'
      'WHERE "photos"."id" = UPDATED."id"',
      values.values,
    );
  }
}

abstract class LikeRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<LikeInsertRequest>,
        ModelRepositoryUpdate<LikeUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory LikeRepository._(Database db) = _LikeRepository;

  Future<BaseLikeView?> queryBaseView(int id);
  Future<List<BaseLikeView>> queryBaseViews([QueryParams? params]);
}

class _LikeRepository extends BaseRepository
    with
        RepositoryInsertMixin<LikeInsertRequest>,
        RepositoryUpdateMixin<LikeUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements LikeRepository {
  _LikeRepository(super.db) : super(tableName: 'likes', keyName: 'id');

  @override
  Future<BaseLikeView?> queryBaseView(int id) {
    return queryOne(id, BaseLikeViewQueryable());
  }

  @override
  Future<List<BaseLikeView>> queryBaseViews([QueryParams? params]) {
    return queryMany(BaseLikeViewQueryable(), params);
  }

  @override
  Future<void> insert(List<LikeInsertRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'INSERT INTO "likes" ( "id", "created_at", "user_id", "photos_id" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8, ${values.add(r.createdAt)}:timestamp, ${values.add(r.userId)}:text, ${values.add(r.photosId)}:text )').join(', ')}\n',
      values.values,
    );
  }

  @override
  Future<void> update(List<LikeUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "likes"\n'
      'SET "created_at" = COALESCE(UPDATED."created_at", "likes"."created_at"), "user_id" = COALESCE(UPDATED."user_id", "likes"."user_id"), "photos_id" = COALESCE(UPDATED."photos_id", "likes"."photos_id")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.createdAt)}:timestamp::timestamp, ${values.add(r.userId)}:text::text, ${values.add(r.photosId)}:text::text )').join(', ')} )\n'
      'AS UPDATED("id", "created_at", "user_id", "photos_id")\n'
      'WHERE "likes"."id" = UPDATED."id"',
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

class PhotoInsertRequest {
  PhotoInsertRequest({
    required this.id,
    required this.url,
    required this.description,
    required this.createdAt,
    required this.creatorId,
  });

  final String id;
  final String url;
  final String description;
  final DateTime createdAt;
  final String creatorId;
}

class LikeInsertRequest {
  LikeInsertRequest({
    required this.id,
    required this.createdAt,
    required this.userId,
    this.photosId,
  });

  final int id;
  final DateTime createdAt;
  final String userId;
  final String? photosId;
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

class PhotoUpdateRequest {
  PhotoUpdateRequest({
    required this.id,
    this.url,
    this.description,
    this.createdAt,
    this.creatorId,
  });

  final String id;
  final String? url;
  final String? description;
  final DateTime? createdAt;
  final String? creatorId;
}

class LikeUpdateRequest {
  LikeUpdateRequest({
    required this.id,
    this.createdAt,
    this.userId,
    this.photosId,
  });

  final int id;
  final DateTime? createdAt;
  final String? userId;
  final String? photosId;
}

class FullUserViewQueryable extends KeyedViewQueryable<FullUserView, String> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(String key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "accounts".*, "photos"."data" as "photos"'
      'FROM "accounts"'
      'LEFT JOIN ('
      '  SELECT "photos"."creator_id",'
      '    to_jsonb(array_agg("photos".*)) as data'
      '  FROM (${BasePhotoViewQueryable().query}) "photos"'
      '  GROUP BY "photos"."creator_id"'
      ') "photos"'
      'ON "accounts"."id" = "photos"."creator_id"';

  @override
  String get tableAlias => 'accounts';

  @override
  FullUserView decode(TypedMap map) => FullUserView(
      id: map.get('id'),
      username: map.get('username'),
      phone: map.getOpt('phone'),
      createdAt: map.get('created_at'),
      photos: map.getListOpt('photos', BasePhotoViewQueryable().decoder) ?? const []);
}

class FullUserView {
  FullUserView({
    required this.id,
    required this.username,
    this.phone,
    required this.createdAt,
    required this.photos,
  });

  final String id;
  final String username;
  final String? phone;
  final DateTime createdAt;
  final List<BasePhotoView> photos;
}

class ReducedUserViewQueryable extends KeyedViewQueryable<ReducedUserView, String> {
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
  ReducedUserView decode(TypedMap map) => ReducedUserView(
      id: map.get('id'), username: map.get('username'), createdAt: map.get('created_at'));
}

class ReducedUserView {
  ReducedUserView({
    required this.id,
    required this.username,
    required this.createdAt,
  });

  final String id;
  final String username;
  final DateTime createdAt;
}

class BaseUserViewQueryable extends KeyedViewQueryable<BaseUserView, String> {
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
  BaseUserView decode(TypedMap map) => BaseUserView(
      id: map.get('id'),
      username: map.get('username'),
      phone: map.getOpt('phone'),
      createdAt: map.get('created_at'),
      passwordHash: map.get('password_hash'));
}

class BaseUserView {
  BaseUserView({
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

class BasePhotoViewQueryable extends KeyedViewQueryable<BasePhotoView, String> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(String key) => TextEncoder.i.encode(key);

  @override
  String get query =>
      'SELECT "photos".*, row_to_json("creator".*) as "creator", "likes"."data" as "likes"'
      'FROM "photos"'
      'LEFT JOIN (${ReducedUserViewQueryable().query}) "creator"'
      'ON "photos"."creator_id" = "creator"."id"'
      'LEFT JOIN ('
      '  SELECT "likes"."photos_id",'
      '    to_jsonb(array_agg("likes".*)) as data'
      '  FROM (${BaseLikeViewQueryable().query}) "likes"'
      '  GROUP BY "likes"."photos_id"'
      ') "likes"'
      'ON "photos"."id" = "likes"."photos_id"';

  @override
  String get tableAlias => 'photos';

  @override
  BasePhotoView decode(TypedMap map) => BasePhotoView(
      id: map.get('id'),
      url: map.get('url'),
      description: map.get('description'),
      createdAt: map.get('created_at'),
      creator: map.get('creator', ReducedUserViewQueryable().decoder),
      likes: map.getListOpt('likes', BaseLikeViewQueryable().decoder) ?? const []);
}

class BasePhotoView {
  BasePhotoView({
    required this.id,
    required this.url,
    required this.description,
    required this.createdAt,
    required this.creator,
    required this.likes,
  });

  final String id;
  final String url;
  final String description;
  final DateTime createdAt;
  final ReducedUserView creator;
  final List<BaseLikeView> likes;
}

class CompletePhotoViewQueryable extends KeyedViewQueryable<CompletePhotoView, String> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(String key) => TextEncoder.i.encode(key);

  @override
  String get query =>
      'SELECT "photos".*, row_to_json("creator".*) as "creator", "likes"."data" as "likes"'
      'FROM "photos"'
      'LEFT JOIN (${ReducedUserViewQueryable().query}) "creator"'
      'ON "photos"."creator_id" = "creator"."id"'
      'LEFT JOIN ('
      '  SELECT "likes"."photos_id",'
      '    to_jsonb(array_agg("likes".*)) as data'
      '  FROM (${BaseLikeViewQueryable().query}) "likes"'
      '  GROUP BY "likes"."photos_id"'
      ') "likes"'
      'ON "photos"."id" = "likes"."photos_id"';

  @override
  String get tableAlias => 'photos';

  @override
  CompletePhotoView decode(TypedMap map) => CompletePhotoView(
      id: map.get('id'),
      url: map.get('url'),
      description: map.get('description'),
      createdAt: map.get('created_at'),
      creator: map.get('creator', ReducedUserViewQueryable().decoder),
      likes: map.getListOpt('likes', BaseLikeViewQueryable().decoder) ?? const []);
}

class CompletePhotoView {
  CompletePhotoView({
    required this.id,
    required this.url,
    required this.description,
    required this.createdAt,
    required this.creator,
    required this.likes,
  });

  final String id;
  final String url;
  final String description;
  final DateTime createdAt;
  final ReducedUserView creator;
  final List<BaseLikeView> likes;
}

class BaseLikeViewQueryable extends KeyedViewQueryable<BaseLikeView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "likes".*, row_to_json("user".*) as "user"'
      'FROM "likes"'
      'LEFT JOIN (${ReducedUserViewQueryable().query}) "user"'
      'ON "likes"."user_id" = "user"."id"';

  @override
  String get tableAlias => 'likes';

  @override
  BaseLikeView decode(TypedMap map) => BaseLikeView(
      id: map.get('id'),
      createdAt: map.get('created_at'),
      user: map.get('user', ReducedUserViewQueryable().decoder));
}

class BaseLikeView {
  BaseLikeView({
    required this.id,
    required this.createdAt,
    required this.user,
  });

  final int id;
  final DateTime createdAt;
  final ReducedUserView user;
}
