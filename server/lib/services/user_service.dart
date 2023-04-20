import 'package:server/database/models.dart';
import 'package:server/grpc-gen/google/protobuf/timestamp.pb.dart';
import 'package:server/grpc-gen/models.pb.dart' as grpc;
import 'package:server/grpc-gen/google/protobuf/empty.pb.dart';
import 'package:grpc/grpc.dart';
import 'package:server/grpc-gen/user_service.pbgrpc.dart';
import 'package:server/utils/auth_utils.dart';
import 'package:stormberry/stormberry.dart';
import 'package:uuid/uuid.dart';

class UserService extends UserServiceBase {
  final UserRepository userRepository;

  UserService({required this.userRepository});

  @override
  Future<CreateUserResponse> createUser(
    ServiceCall call,
    CreateUserRequest request,
  ) async {
    final user = request.user;
    final username = user.username;
    final withSimilarUserName = await userRepository.query(
      UserNameQuery(),
      username,
    );
    if (withSimilarUserName != null) {
      throw GrpcError.alreadyExists(
        'User with username: $username already exists',
      );
    }
    final id = Uuid().v4();
    // call method to hash password using OpenBSD
    final passwordHash = hashPassword(request.password);
    await userRepository.insertOne(
      UserInsertRequest(
        id: id,
        username: username,
        createdAt: DateTime.now(),
        passwordHash: passwordHash,
      ),
    );
    final gotUser = await userRepository.queryUser(id);
    return CreateUserResponse(
      user: gotUser!.asGrpcUser(),
      jwt: createJwt(gotUser),
    );
  }

  @override
  Future<Empty> deleteUser(
    ServiceCall call,
    DeleteUserRequest request,
  ) async {
    await userRepository.deleteOne(request.id);
    return Empty();
  }

  @override
  Future<grpc.User> getUser(
    ServiceCall call,
    GetUserRequest request,
  ) async {
    final user = await userRepository.queryUser(request.id);
    if (user == null) {
      throw GrpcError.notFound();
    }
    return user.asGrpcUser();
  }

  @override
  Future<ListUsersResponse> listUsers(
    ServiceCall call,
    ListUsersRequest request,
  ) async {
    final offSet = int.tryParse(request.pageToken) ?? 0;
    final users = await userRepository.queryUsers(
      QueryParams(offset: offSet, limit: 100),
    );
    return ListUsersResponse(
      nextPageToken: '${offSet + 100}',
      users: users.map((e) => e.asGrpcUser()).toList(),
    );
  }

  @override
  Future<LoginResponse> login(
    ServiceCall call,
    LoginRequest request,
  ) async {
    final username = request.username;
    final password = request.password;
    final user = await userRepository.query(UserNameQuery(), username);
    if (user == null) {
      throw GrpcError.notFound('$username not found');
    }
    final passwordsMatch = checkPassword(password, user.passwordHash);
    if (passwordsMatch) {
      final jwt = createJwt(user);
      return LoginResponse(
        accessToken: jwt,
      );
    }
    throw GrpcError.unauthenticated('Wrong username and password');
  }

  @override
  Future<grpc.User> updateUser(
    ServiceCall call,
    UpdateUserRequest request,
  ) async {
    final user = request.user;
    final updateMaskPaths = request.updateMask.paths;
    String? username;
    String? phone;

    for (var path in updateMaskPaths) {
      if (path == 'username') {
        username = user.username;
      }
      if (path == 'phone') {
        phone = user.phone;
      }
    }

    final userUpdateRequest = UserUpdateRequest(
      id: user.id,
      phone: phone,
      username: username,
    );
    await userRepository.updateOne(userUpdateRequest);
    final updatedUser = await userRepository.queryUser(user.id);
    return updatedUser!.asGrpcUser();
  }
}

extension AsGrpcUser on UserView {
  grpc.User asGrpcUser() {
    return grpc.User(
      createdAt: Timestamp.fromDateTime(createdAt),
      id: id,
      phone: phone,
      username: username,
    );
  }
}
