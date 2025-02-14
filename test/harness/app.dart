import 'package:proyecto/proyecto.dart';
import 'package:conduit_test/conduit_test.dart';

export 'package:proyecto/proyecto.dart';
export 'package:conduit_test/conduit_test.dart';
export 'package:test/test.dart';
export 'package:conduit_core/conduit_core.dart';

/// A testing harness for proyecto.
///
/// A harness for testing an conduit application. Example test file:
///
///         void main() {
///           Harness harness = Harness()..install();
///
///           test("GET /path returns 200", () async {
///             final response = await harness.agent.get("/path");
///             expectResponse(response, 200);
///           });
///         }
///
class Harness extends TestHarness<MyBackendChannel> {
  @override
  Future onSetUp() async {}

  @override
  Future onTearDown() async {}
}
