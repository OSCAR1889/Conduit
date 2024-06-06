import 'package:conduit/conduit.dart';
import 'package:proyecto/models/user.dart';
import 'package:proyecto/proyecto.dart';

class UserController extends ResourceController {
  UserController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllUsers() async {
    print('Ejecutando método getAllUsers');
    final userQuery = Query<User>(context);
    final users = await userQuery.fetch();
    print('Usuarios obtenidos: $users');
    return Response.ok(users);
  }

  @Operation.post()
  Future<Response> createUser(@Bind.body() User user) async {
    print('Ejecutando método createUser');
    final query = Query<User>(context)..values = user;
    final insertedUser = await query.insert();
    print('Usuario insertado: $insertedUser');
    return Response.ok(insertedUser);
  }

  @Operation.delete('id')
  Future<Response> deleteUserByID(@Bind.path('id') int id) async {
    print('Ejecutando método deleteUserByID con ID: $id');
    final query = Query<User>(context)..where((u) => u.id).equalTo(id);
    final deletedCount = await query.delete();
    if (deletedCount! > 0) {
      return Response.ok({'message': 'Usuario con ID $id eliminado correctamente'});
    } else {
      return Response.notFound(body: {'error': 'Usuario con ID $id no encontrado'});
    }
  }

  @Operation.put('id')
  Future<Response> updateUserByID(@Bind.path('id') int id, @Bind.body() User user) async {
    print('Ejecutando método updateUserByID con ID: $id');
    final query = Query<User>(context)
      ..where((u) => u.id).equalTo(id)
      ..values = user;
    final updatedUser = await query.updateOne();
    if (updatedUser != null) {
      return Response.ok(updatedUser);
    } else {
      return Response.notFound(body: {'error': 'Usuario con ID $id no encontrado'});
    }
  }
}
