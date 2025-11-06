// part of 'usuario_lista_bloc.dart';

// sealed class UsuarioListaState extends Equatable {
//   const UsuarioListaState();

//   @override
//   List<Object?> get props => [];
// }

// class UsuariosInicial extends UsuarioListaState {
//   const UsuariosInicial();
// }

// class CargandoUsuarios extends UsuarioListaState {
//   const CargandoUsuarios();
// }

// class UsuariosCargados extends UsuarioListaState {
//   final Stream<List<Usuario>> usuarios;
//   final Roles rol;

//   const UsuariosCargados({required this.usuarios, required this.rol});

//   @override
//   List<Object?> get props => [rol];
// }

// class ErrorCargandoUsuarios extends UsuarioListaState {
//   final String mensaje;

//   const ErrorCargandoUsuarios(this.mensaje);

//   @override
//   List<Object?> get props => [mensaje];
// }

// class TodosLosRolesCargados extends UsuarioListaState {
//   final Map<Roles, Stream<List<Usuario>>> usuariosPorRol;

//   const TodosLosRolesCargados(this.usuariosPorRol);

//   Stream<List<Usuario>> getStreamPorRol(Roles rol) {
//     return usuariosPorRol[rol] ?? Stream.value([]);
//   }

//   bool tieneRol(Roles rol) {
//     return usuariosPorRol.containsKey(rol);
//   }

//   @override
//   List<Object?> get props => [usuariosPorRol.keys.toList()];
// }
