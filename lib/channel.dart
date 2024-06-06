import 'package:conduit/conduit.dart';
import 'package:conduit_postgresql/conduit_postgresql.dart';
import 'package:proyecto/controllers/category_controller.dart';
import 'package:proyecto/controllers/comment_controller.dart';
import 'package:proyecto/controllers/topper_controller.dart';
import 'package:proyecto/controllers/user_controller.dart';
import 'package:proyecto/proyecto.dart';

class MyBackendChannel extends ApplicationChannel {
  late ManagedContext context;

  @override
  Future<void> prepare() async {
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      'mydbuser', // Usuario
      'mydbpassword', // Contraseña
      'localhost', // Host
      5432, // Puerto
      'toppersdb', // Nombre de la base de datos
    );

    context = ManagedContext(dataModel, persistentStore);
    print('Base de datos conectada'); // Mensaje de depuración
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
      .route('/users/[:id]')
      .link(() => UserController(context));

    router
      .route('/toppers/[:id]')
      .link(() => TopperController(context));
     
    router
      .route('/comment/[:id]')
      .link(() => CommentController(context));

    router
      .route('/category/[:id]')
      .link(() => CategoryController(context));
  
    print('Rutas configuradas');
    return router;
  }
}
