import 'package:conduit/conduit.dart';
import 'package:proyecto/models/topper.dart';
import 'package:proyecto/proyecto.dart';

class TopperController extends ResourceController {
  TopperController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getToppers() async {
    print('Ejecutando método getToppers');
    final topperQuery = Query<Topper>(context);
    final toppers = await topperQuery.fetch();
    print('Toppers obtenidos: $toppers');
    return Response.ok(toppers);
  }

  @Operation.post()
  Future<Response> createTopper(@Bind.body() Topper topper) async {
    print('Ejecutando método createTopper');
    topper.createdAt = DateTime.now();
    final query = Query<Topper>(context)..values = topper;
    final insertedTopper = await query.insert();
    print('Topper insertado: $insertedTopper');
    return Response.ok(insertedTopper);
  }

  @Operation.delete('id')
  Future<Response> deleteTopperByID(@Bind.path('id') int id) async {
    print('Ejecutando método deleteTopperByID con ID: $id');
    final query = Query<Topper>(context)..where((t) => t.id).equalTo(id);
    final deletedCount = await query.delete();
    if (deletedCount! > 0) {
      return Response.ok({'message': 'trTopper con ID $id eliminado correctamente'});
    } else {
      return Response.notFound(body: {'error': 'Topper con ID $id no encontrado'});
    }
  }
  @Operation.put('id')
  Future<Response> updateTopperByID(@Bind.path('id') int id, @Bind.body() Topper updatedTopper) async {
  print('Ejecutando método updateTopperByID con ID: $id');

  final query = Query<Topper>(context)
    ..where((t) => t.id).equalTo(id)
    ..values = updatedTopper;

  try {
    final updatedTopper = await query.updateOne();
    if (updatedTopper == null) {
      return Response.notFound(body: {'error': 'Topper con ID $id no encontrado'});
    }
    return Response.ok(updatedTopper);
  } catch (e, stackTrace) {
    print('Error al actualizar topper: $e');
    print(stackTrace);
    return Response.serverError(body: {'error': 'No se pudo actualizar el topper con ID $id', 'details': e.toString()});
  }
}

}
