import 'package:dotenv/dotenv.dart';
import 'package:stormberry/stormberry.dart';

void main(List<String> arguments) {
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
}
