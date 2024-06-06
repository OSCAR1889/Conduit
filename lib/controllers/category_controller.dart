import 'package:conduit/conduit.dart';
import 'package:proyecto/models/category.dart';
import 'package:proyecto/proyecto.dart';

class CategoryController extends ResourceController {
  CategoryController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllCategories() async {
    print('Ejecutando método getAllCategories');
    final categoryQuery = Query<Category>(context);
    final categories = await categoryQuery.fetch();
    print('Categorías obtenidas: $categories');
    return Response.ok(categories);
  }

  @Operation.post()
  Future<Response> createCategory(@Bind.body() Category category) async {
    print('Ejecutando método createCategory');
    final query = Query<Category>(context)..values = category;
    final insertedCategory = await query.insert();
    print('Categoría insertada: $insertedCategory');
    return Response.ok(insertedCategory);
  }

  @Operation.delete('id')
  Future<Response> deleteCategoryByID(@Bind.path('id') int id) async {
    print('Ejecutando método deleteCategoryByID con ID: $id');
    final query = Query<Category>(context)..where((c) => c.id).equalTo(id);
    final deletedCount = await query.delete();
    if (deletedCount! > 0) {
      return Response.ok({'message': 'Categoría con ID $id eliminada correctamente'});
    } else {
      return Response.notFound(body: {'error': 'Categoría con ID $id no encontrada'});
    }
  }

  @Operation.put('id')
  Future<Response> updateCategoryByID(@Bind.path('id') int id, @Bind.body() Category category) async {
    print('Ejecutando método updateCategoryByID con ID: $id');
    final query = Query<Category>(context)
      ..where((c) => c.id).equalTo(id)
      ..values = category;
    final updatedCategory = await query.updateOne();
    if (updatedCategory != null) {
      return Response.ok(updatedCategory);
    } else {
      return Response.notFound(body: {'error': 'Categoría con ID $id no encontrada'});
    }
  }
}
