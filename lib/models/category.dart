import 'package:conduit/conduit.dart';
import 'package:proyecto/models/topper.dart';
import 'package:proyecto/proyecto.dart';

class Category extends ManagedObject<_Category> implements _Category {}

@Table(name: 'Category')
class _Category {
  @primaryKey
  int? id;

  @Column(nullable: false)
  late String name;

  @Column(nullable: false)
  late String description;
}
