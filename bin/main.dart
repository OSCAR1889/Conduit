import 'package:conduit/conduit.dart';
import 'package:proyecto/channel.dart';
import 'package:proyecto/proyecto.dart';

Future main() async {
  final app = Application<MyBackendChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 8888;

  await app.start(numberOfInstances: 1, consoleLogging: true);
}