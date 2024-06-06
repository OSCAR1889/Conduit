import 'package:conduit/conduit.dart';
import 'package:proyecto/proyecto.dart';

class Topper extends ManagedObject<_Topper> implements _Topper {}

@Table(name: 'Toppers')
class _Topper {
  @primaryKey
  int? id;

  @Column(nullable: false)
  late String title;

  @Column(nullable: false)
  late String description;

  @Column(nullable: false)
  late String imageUrl;

  @Column(nullable: false)
  late int userId;

   @Column(nullable: false)
  late int categoryId;

  @Column(nullable: false)
  late DateTime createdAt;
}
