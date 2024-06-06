import 'package:conduit/conduit.dart';
import 'package:proyecto/models/topper.dart';
import 'package:proyecto/models/user.dart';
import 'package:proyecto/proyecto.dart';

class Comment extends ManagedObject<_Comment> implements _Comment {}

@Table(name: 'Comment')
class _Comment {
  @primaryKey
  int? id;

  @Column(nullable: false)
  late String content;

  @Column(nullable: false)
  late int userId;

  @Column(nullable: false)
  late int topperId;

  @Column(nullable: false)
  late DateTime createdAt;

}
