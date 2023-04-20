import 'package:server/database/models.dart';
import 'package:server/grpc-gen/models.pb.dart' as grpc;
import 'package:server/grpc-gen/google/protobuf/empty.pb.dart';
import 'package:grpc/grpc.dart';
import 'package:server/grpc-gen/user_service.pbgrpc.dart';

class UserService extends UserServiceBase {
  final UserRepository userRepository;

  UserService({required this.userRepository});

  @override
  Future<CreateUserResponse> createUser(
    ServiceCall call,
    CreateUserRequest request,
  ) async {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Empty> deleteUser(
    ServiceCall call,
    DeleteUserRequest request,
  ) async {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<grpc.User> getUser(
    ServiceCall call,
    GetUserRequest request,
  ) async {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<ListUsersResponse> listUsers(
    ServiceCall call,
    ListUsersRequest request,
  ) async {
    // TODO: implement listUsers
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> login(
    ServiceCall call,
    LoginRequest request,
  ) async {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<grpc.User> updateUser(
    ServiceCall call,
    UpdateUserRequest request,
  ) async {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
