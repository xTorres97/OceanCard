// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// import '../../../core/enum/roles.dart';
// import '../../../core/log_locat.dart';
// import '../../../data/models/usuario_model.dart';
// import '../../../domain/usecases/usuario/actualizar_datos_usuario_usecase.dart';
// import '../../../domain/usecases/usuario/eliminar_usuario_usecase.dart';
// import '../../../domain/usecases/usuario/registrar_usuario_usecase.dart';

// part 'usuario_operaciones_event.dart';
// part 'usuario_operaciones_state.dart';

// class UsuarioOperacionesBloc
//     extends Bloc<UsuarioOperacionesEvent, UsuarioOperacionesState> {
//   final RegistrarUsuarioUseCase registrarUsuarioUseCase;
//   final ActualizarDatosUsuarioUseCase actualizarDatosUsuarioUseCase;
//   final EliminarUsuarioUseCase eliminarUsuarioUseCase;

//   UsuarioOperacionesBloc({
//     required this.registrarUsuarioUseCase,
//     required this.actualizarDatosUsuarioUseCase,
//     required this.eliminarUsuarioUseCase,
//   }) : super(OperacionesInicial()) {
//     on<CrearUsuario>(_onCrearUsuario);
//     on<ActualizarUsuario>(_onActualizarUsuario);
//     on<EliminarUsuario>(_onEliminarUsuario);
//   }

//   Future<void> _onCrearUsuario(
//     CrearUsuario event,
//     Emitter<UsuarioOperacionesState> emit,
//   ) async {
//     emit(Creando());
//     try {
//       final usuario = await registrarUsuarioUseCase(
//         Usuario.empty.copyWith(
//           name: event.name,
//           email: event.email,
//           role: event.rol,
//         ),
//         event.password,
//       );
//       emit(Creado('Usuario creado: ${usuario.name}'));
//     } catch (e) {
//       emit(CreandoError('Error al crear usuario: $e'));
//       logWithLocation('Error al crear usuario: $e');
//     }
//   }

//   Future<void> _onActualizarUsuario(
//     ActualizarUsuario event,
//     Emitter<UsuarioOperacionesState> emit,
//   ) async {
//     emit(Creando());
//     try {
//       await actualizarDatosUsuarioUseCase(
//         event.usuario,
//         event.contrasena != '' ? event.contrasena : null,
//       );
//       emit(Actualizado('Usuario actualizado!'));
//     } catch (e) {
//       emit(EliminandoError('Error al actualizar usuario: $e'));
//       logWithLocation('Error al actualizar usuario: $e');
//     }
//   }

//   Future<void> _onEliminarUsuario(
//     EliminarUsuario event,
//     Emitter<UsuarioOperacionesState> emit,
//   ) async {
//     emit(Eliminando());
//     try {
//       await eliminarUsuarioUseCase(event.userId);
//       emit(Eliminado('Usuario eliminado!'));
//     } catch (e) {
//       emit(EliminandoError('Error al eliminar usuario: $e'));
//       logWithLocation('Error al eliminar usuario: $e');
//     }
//   }
// }
