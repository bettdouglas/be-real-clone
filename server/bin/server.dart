import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:grpc/grpc.dart';
import 'package:server/database/models.dart';
import 'package:server/interceptors/auth_interceptor.dart';
import 'package:server/services/user_service.dart';
import 'package:server/utils/dotenv.dart';
import 'package:stormberry/stormberry.dart';

void main(List<String> arguments) async {
  final database = Database(
    database: dotEnv.getOrElse(
      'POSTGRES_DB',
      () => throw Exception('POSTGRES_DB not defined'),
    ),
    host: dotEnv.getOrElse(
      'POSTGRES_HOST',
      () => throw Exception('POSTGRES_HOST not defined'),
    ),
    port: int.parse(dotEnv.getOrElse(
      'POSTGRES_PORT',
      () => throw Exception('POSTGRES_PORT not defined'),
    )),
    useSSL: false,
    user: dotEnv.getOrElse(
      'POSTGRES_USER',
      () => throw Exception('POSTGRES_USER not defined'),
    ),
    password: dotEnv.getOrElse(
      'POSTGRES_PASSWORD',
      () => throw Exception('POSTGRES_PASSWORD not defined'),
    ),
  );

  final interceptors = <Interceptor>[
    authInterceptor,
  ];
  final server = Server(
    [UserService(userRepository: database.users)],
    interceptors,
  );
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(dotEnv.getOrElse('PORT', () => '8087'));

  await server.serve(address: ip, port: port);

  print('Server running at $ip on $port');
}
