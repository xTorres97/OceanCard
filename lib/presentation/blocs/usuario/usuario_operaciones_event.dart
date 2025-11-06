// part of 'usuario_operaciones_bloc.dart';

// sealed class UsuarioOperacionesEvent extends Equatable {
//   const UsuarioOperacionesEvent();

//   @override
//   List<Object> get props => [];
// }

// class CrearUsuario extends UsuarioOperacionesEvent {
//   final String name;
//   final String email;
//   final Roles rol;
//   final String password;

//   const CrearUsuario({
//     required this.name,
//     required this.email,
//     required this.rol,
//     required this.password,
//   });

//   @override
//   List<Object> get props => [name, email, rol, password];
// }

// class ActualizarUsuario extends UsuarioOperacionesEvent {
//   final Usuario usuario;
//   final String? contrasena;

//   const ActualizarUsuario({required this.usuario, this.contrasena});

//   @override
//   List<Object> get props => [usuario, contrasena ?? ''];
// }

// class EliminarUsuario extends UsuarioOperacionesEvent {
//   final String userId;
//   final Roles rol;

//   const EliminarUsuario({required this.userId, required this.rol});

//   @override
//   List<Object> get props => [userId, rol];
// }
