// part of 'usuario_operaciones_bloc.dart';

// sealed class UsuarioOperacionesState extends Equatable {
//   const UsuarioOperacionesState();

//   @override
//   List<Object> get props => [];
// }

// // Estado inicial
// class OperacionesInicial extends UsuarioOperacionesState {}

// // Estados de carga
// class Creando extends UsuarioOperacionesState {}

// class Actualizando extends UsuarioOperacionesState {}

// class Eliminando extends UsuarioOperacionesState {}

// // Estados de éxito
// class Creado extends UsuarioOperacionesState {
//   final String mensaje;

//   const Creado(this.mensaje);

//   @override
//   List<Object> get props => [mensaje];
// }

// class Actualizado extends UsuarioOperacionesState {
//   final String mensaje;

//   const Actualizado(this.mensaje);

//   @override
//   List<Object> get props => [mensaje];
// }

// class Eliminado extends UsuarioOperacionesState {
//   final String mensaje;

//   const Eliminado(this.mensaje);

//   @override
//   List<Object> get props => [mensaje];
// }

// // Estados de error
// class CreandoError extends UsuarioOperacionesState {
//   final String mensaje;

//   const CreandoError(this.mensaje);

//   @override
//   List<Object> get props => [mensaje];
// }

// class ActualizandoError extends UsuarioOperacionesState {
//   final String mensaje;

//   const ActualizandoError(this.mensaje);

//   @override
//   List<Object> get props => [mensaje];
// }

// class EliminandoError extends UsuarioOperacionesState {
//   final String mensaje;

//   const EliminandoError(this.mensaje);

//   @override
//   List<Object> get props => [mensaje];
// }
