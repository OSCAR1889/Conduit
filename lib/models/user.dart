import 'package:conduit/conduit.dart';
import 'package:proyecto/proyecto.dart';

class User extends ManagedObject<_User> implements _User {}

@Table(name: 'Users')
class _User {
  @primaryKey
  int? id;

  @Column(unique: true, nullable: false)
  late String username;

  @Column(unique: true, nullable: false)
  late String email;

  @Column(nullable: false)
  late String password;

  @Column(nullable: true)
  String? url; // URL de la foto de perfil del usuario

  @Column(nullable: true)
  String? fullName; // Nombre completo del usuario

  @Column(nullable: true)
  DateTime? birthDate; // Fecha de nacimiento del usuario
}
