import 'package:conduit/conduit.dart';
import 'package:proyecto/models/comment.dart';
import 'package:proyecto/proyecto.dart';

class CommentController extends ResourceController {
  CommentController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllComments() async {
    print('Ejecutando método getAllComments');
    final commentQuery = Query<Comment>(context);
    final comments = await commentQuery.fetch();
    print('Comentarios obtenidos: $comments');
    return Response.ok(comments);
  }

  @Operation.post()
  Future<Response> createComment(@Bind.body() Comment comment) async {
    print('Ejecutando método createComment');
    comment.createdAt = DateTime.now();
    final query = Query<Comment>(context)..values = comment;
    final insertedComment = await query.insert();
    print('Comentario insertado: $insertedComment');
    return Response.ok(insertedComment);
  }

  @Operation.delete('id')
  Future<Response> deleteCommentByID(@Bind.path('id') int id) async {
    print('Ejecutando método deleteCommentByID con ID: $id');
    final query = Query<Comment>(context)..where((c) => c.id).equalTo(id);
    final deletedCount = await query.delete();
    if (deletedCount! > 0) {
      return Response.ok({'message': 'Comentario con ID $id eliminado correctamente'});
    } else {
      return Response.notFound(body: {'error': 'Comentario con ID $id no encontrado'});
    }
  }

  @Operation.put('id')
  Future<Response> updateCommentByID(@Bind.path('id') int id, @Bind.body() Comment comment) async {
    print('Ejecutando método updateCommentByID con ID: $id');
    comment.createdAt = DateTime.now();
    final query = Query<Comment>(context)
      ..where((c) => c.id).equalTo(id)
      ..values = comment;
    final updatedComment = await query.updateOne();
    if (updatedComment != null) {
      return Response.ok(updatedComment);
    } else {
      return Response.notFound(body: {'error': 'Comentario con ID $id no encontrado'});
    }
  }
}
